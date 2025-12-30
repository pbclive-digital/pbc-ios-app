//
//  NetError.swift
//  LibNetwork
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import Foundation
import LibCommonData

//public enum AppErrorType: Codable {
//    case HTTP_ERROR, UNATHORIZED, NO_INTERNET, NO_CONNECTION, ALAMOFIRE_FAILURE, NO_SURVEY_SELECTED
//}

//public enum AppErrorNavigateType: Codable {
//    case CLOSE, BACK
//}

public enum AppErrorNavigateType: String, Codable {
    case CLOSE = "CLOSE"
    case BACK = "BACK"
}

public struct NetError: Codable, Sendable {
    public var errorType: AppErrorType
    public var errorCode: Int? = nil
    public var errorMessage: String? = nil

    public init(errorType: AppErrorType, errorCode: Int? = 0, errorMessage: String? = nil) {
        self.errorType = errorType
        self.errorCode = errorCode
        self.errorMessage = errorMessage
    }
}
