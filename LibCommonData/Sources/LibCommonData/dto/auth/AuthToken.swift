//
//  AuthToken.swift
//  LibCommonData
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import Foundation

public struct AuthToken: Codable, Sendable {
    public var id: String? = nil
    public let email: String?
    public var userId: String?
    public var token: String? = nil
    public var status: String = ""
    public var createdTime: Double? = nil

    public init(email: String, userId: String?) {
        self.email = email
        self.userId = userId
        self.status = "VALID"
    }
}
