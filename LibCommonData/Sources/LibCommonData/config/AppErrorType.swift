//
//  AppErrorType.swift
//  LibCommonData
//
//  Created by Kavimal Wijewardana on 12/29/25.
//
public enum AppErrorType: String, Codable, Sendable {
    case GENERAL = "GENERAL"
    case HTTP_ERROR = "HTTP_ERROR"
    case UNATHORIZED = "UNATHORIZED"
    case NO_INTERNET = "NO_INTERNET"
    case NO_CONNECTION = "NO_CONNECTION"
    case NEED_UPDATE = "NEED_UPDATE"
    case ALAMOFIRE_FAILURE = "ALAMOFIRE_FAILURE"
}

public enum AppErrorNavigateType: String, Codable {
    case CLOSE = "CLOSE"
    case BACK = "BACK"
}
