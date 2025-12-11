//
//  AppNetwork.swift
//  LibNetwork
//
//  Created by Kavimal Wijewardana on 12/10/25.
//
import Foundation
import Alamofire

public protocol NetworkProtocol {
    
    func initialize(netConfig: NetConfig)
    
    func invokeGET<T: Decodable & Sendable>(path: String, responseType: T.Type, onSuccess: @Sendable @escaping ( _ response: T) -> Void, onError: @Sendable @escaping ( _ error: NetError?) -> Void)
    
    func invokePOST<T: Decodable & Sendable>(path: String, parameters: Encodable & Sendable, responseType: T.Type, onSuccess: @Sendable @escaping ( _ response: T) -> Void, onError: @Sendable @escaping ( _ error: NetError?) -> Void)
    
    func invokePUT<T: Decodable & Sendable>(path: String, parameters: Encodable & Sendable, responseType: T.Type, onSuccess: @Sendable @escaping ( _ response: T) -> Void, onError: @Sendable @escaping ( _ error: NetError?) -> Void)
    
    func invokeDELETE<T: Decodable & Sendable>(path: String, responseType: T.Type, onSuccess: @Sendable @escaping ( _ response: T) -> Void, onError: @Sendable @escaping ( _ error: NetError?) -> Void)
    
    func invokeUploadFile<T: Decodable & Sendable>(path: String, fileURL: URL, responseType: T.Type, onSuccess: @Sendable @escaping ( _ response: T) -> Void, onError: @Sendable @escaping ( _ error: NetError?) -> Void)
    
    func downloadFile(url: URL, onSuccess: @Sendable @escaping () -> Void, onFailure: @Sendable @escaping (Int, String) -> Void)
}
