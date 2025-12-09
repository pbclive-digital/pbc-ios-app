//
//  BaseResponse.swift
//  LibNetwork
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import Foundation
import LibCommonData

//enum ResponseStatus: String, Decodable {
//    case SUCCSS
//    case ERROR
//    case PENDING
//}

public struct AppError: Decodable, Sendable {
    public var message: String
}

public struct BaseResponse<T: Decodable & Sendable>: Decodable, Sendable {
    public var status: String
    public var body: T
    public var errors: Array<AppError>?
}
