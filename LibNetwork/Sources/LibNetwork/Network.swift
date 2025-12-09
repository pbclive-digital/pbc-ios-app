//
//  Network.swift
//  LibNetwork
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import Foundation
import Alamofire

public class Network {

    var network: Network?
    var netConfig: NetConfig? = nil

    public init() {}

    public func getInstance() -> Network? {
        if (network == nil) {
            network = Network()
        }
        return network
    }

    public func initialize(netConfig: NetConfig) {
        self.netConfig = netConfig
    }

    public func getBaseUrl() -> String? {
        return (netConfig?.schema ?? "") + "://" + (netConfig?.domain ?? "")
    }

    public func invokeGET<T: Decodable & Sendable>(path: String, responseType: T.Type, onSuccess: @Sendable @escaping ( _ response: T) -> Void, onError: @Sendable @escaping ( _ error: NetError?) -> Void) {

        let urlPath = (getBaseUrl() ?? "") + path
        print("NETWORK URL: GET: \(urlPath)")

        AF.request(urlPath, method: .get, headers: setHeaders())
            .validate()
            .responseDecodable(of: responseType, decoder: JSONDecoder.enumDecorder) { response in
                switch response.result {
                case .success(let res):
                    print("NETWORK SUCCESS: \(res)")
                    onSuccess(res)
                case .failure(let error):
                    print("NETWORK ERROR: \(error)")
                    onError(self.generateNetError(afError: error))
                }
            }
    }

    public func invokePOST<T: Decodable & Sendable>(path: String, parameters: Encodable & Sendable, responseType: T.Type, onSuccess: @Sendable @escaping ( _ response: T) -> Void, onError: @Sendable @escaping ( _ error: NetError?) -> Void) {

        let urlPath = (getBaseUrl() ?? "") + path
        print("NETWORK URL: POST: \(urlPath)")

        AF.request(urlPath, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: setHeaders())
            .validate()
//            .response { res in
//                print(res)
//                completion(.success(nil))
//            }
            .responseDecodable(of: responseType.self) { response in
                switch response.result {
                case .success(let res):
                    print("NETWORK SUCCESS: \(res)")
                    onSuccess(res)
                case .failure(let error):
                    print("NETWORK ERROR: \(error)")
                    onError(self.generateNetError(afError: error))
                }
            }
    }

    public func invokePUT<T: Decodable & Sendable>(path: String, parameters: Encodable & Sendable, responseType: T.Type, onSuccess: @Sendable @escaping ( _ response: T) -> Void, onError: @Sendable @escaping ( _ error: NetError?) -> Void) {

        let urlPath = (getBaseUrl() ?? "") + path
        print("NETWORK URL: PUT: \(urlPath)")

        AF.request(urlPath, method: .put, parameters: parameters, encoder: JSONParameterEncoder.default, headers: setHeaders())
            .validate()
            .responseDecodable(of: responseType.self) { response in
                switch response.result {
                case .success(let res):
                    print("NETWORK SUCCESS: \(res)")
                    onSuccess(res)
                case .failure(let error):
                    print("NETWORK ERROR: \(error)")
                    onError(self.generateNetError(afError: error))
                }
            }
    }

    public func invokeDELETE<T: Decodable & Sendable>(path: String, responseType: T.Type, onSuccess: @Sendable @escaping ( _ response: T) -> Void, onError: @Sendable @escaping ( _ error: NetError?) -> Void) {
        let urlPath = (getBaseUrl() ?? "") + path
        print("NETWORK URL: DELETE: \(urlPath)")

        AF.request(urlPath, method: .delete, headers: setHeaders())
            .validate()
            .responseDecodable(of: responseType, decoder: JSONDecoder.enumDecorder) { response in
                switch response.result {
                case .success(let res):
                    print("NETWORK SUCCESS: \(res)")
                    onSuccess(res)

                case .failure(let error):
                    print("NETWORK ERROR: \(error)")
                    onError(self.generateNetError(afError: error))
                }
            }
    }

    public func invokeUploadFile<T: Decodable & Sendable>(path: String, fileURL: URL, responseType: T.Type, onSuccess: @Sendable @escaping ( _ response: T) -> Void, onError: @Sendable @escaping ( _ error: NetError?) -> Void) {
        let urlPath = (getBaseUrl() ?? "") + path
        print("NETWORK URL: UPLOAD: \(urlPath)")

        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(fileURL, withName: "file", fileName: fileURL.lastPathComponent, mimeType: "application/octet-stream")
            },
            to: urlPath,
            headers: setHeaders()
        )
        .validate()
        .responseDecodable(of: responseType, decoder: JSONDecoder.enumDecorder) { response in
            switch response.result {
            case .success(let res):
                print("NETWORK SUCCESS: \(res)")
                onSuccess(res)

            case .failure(let error):
                print("NETWORK ERROR: \(error)")
                onError(self.generateNetError(afError: error))
            }
        }
    }

    public func downloadFile(url: URL, onSuccess: @Sendable @escaping () -> Void, onFailure: @Sendable @escaping (Int, String) -> Void) {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path) {
            onFailure(0, "File already exists")
        } else {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler: { data, response, error in
                if error == nil {
                    if let response = response as? HTTPURLResponse {
                        if response.statusCode == 200 {
                            if let data = data {
                                if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic) {
                                    onSuccess()
                                } else {
                                    onFailure(-1, "Writing the downloaded content to file failure.")
                                }
                            } else {
                                onFailure(-2, "Downloaded content is empty")
                            }
                        } else {
                            onFailure(-3, "Network failure. Status code: \(String(describing: response.statusCode))")
                        }
                    }
                } else {
                    onFailure(-4, ": \(String(describing: error))")
                }
            })

            task.resume()
        }
    }

    // Generate required available header for any API request
    private func setHeaders() -> HTTPHeaders {
        var headers = [
                HTTPHeader(name: "Accept", value: "application/json"),
                HTTPHeader(name: "Content-Type", value: "application/json"),
                HTTPHeader(name: "X-app-os", value: "ios")
        ]

//        if let token = Session.getInstance()?.authToken?.token {
//            headers.append(HTTPHeader(name: "Authorization", value: "Bearer \(token)"))
//        }
//
//        if let user = Session.getInstance()?.user {
//            if let userJSONString = JSONSerialization.toJsonString(dataObj: user) {
//                headers.append(HTTPHeader(name: "X-app-user", value: userJSONString))
//            }
//        }

        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            headers.append(HTTPHeader(name: "X-app-version", value: appVersion))
        }

        return HTTPHeaders(headers)
    }

    private func generateNetError(afError: AFError) -> NetError? {
        if let err = afError.underlyingError as? URLError {
            switch err.code {
            case .notConnectedToInternet:
                return NetError(errorType: AppErrorType.NO_INTERNET)
            case .networkConnectionLost:
                return NetError(errorType: AppErrorType.NO_CONNECTION)
            default:
                return NetError(errorType: AppErrorType.ALAMOFIRE_FAILURE)
            }
        } else {
            return NetError(errorType: AppErrorType.HTTP_ERROR, errorCode: afError.responseCode, errorMessage: afError.errorDescription)
        }
    }
}
