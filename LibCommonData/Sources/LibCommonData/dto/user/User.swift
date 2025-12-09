//
//  User.swift
//  LibCommonData
//
//  Created by Kavimal Wijewardana on 12/8/25.
//

public struct User: Codable, Sendable {
    public var id: String? = nil
    public var email: String = ""
    public var firstName: String = ""
    public var lastName: String = ""
    public var phoneNumber: String = ""
    public var profilePicUrl: String = ""
    public var address: String = ""
    public var userType: String = ""
    public var residentMonk: Bool = false
    public var userAuthType: String = ""
}
