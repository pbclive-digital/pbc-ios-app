//
//  User.swift
//  LibCommonData
//
//  Created by Kavimal Wijewardana on 12/8/25.
//

public struct PBCUser: Codable, Sendable, Equatable {
    public var id: String? = nil
    public var email: String = ""
    public var firstName: String = ""
    public var lastName: String = ""
    public var phoneNumber: String? = ""
    public var profilePicUrl: String? = ""
    public var address: String? = ""
    public var userType: String = ""
    public var residentMonk: Bool = false
    public var userAuthType: String = ""
    
    public init() {}
    
    public init(id: String, email: String, firstName: String, lastName: String, phoneNum: String?, profilePicUrl: String?, address: String?, userType: String, isResidentMonk: Bool, userAuthType: String) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNum
        self.profilePicUrl = profilePicUrl
        self.address = address
        self.userType = userType
        self.residentMonk = isResidentMonk
        self.userAuthType = userAuthType
    }
}
