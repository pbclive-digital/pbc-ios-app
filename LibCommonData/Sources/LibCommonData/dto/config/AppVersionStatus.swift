//
//  AppVersionStatus.swift
//  LibCommonData
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import Foundation

public struct AppVersionStatus: Codable, Sendable {
    public var support: Bool = false
    public var supportingVersion: String = ""

    public init(support: Bool, supportingVersion: String) {
        self.support = support
        self.supportingVersion = supportingVersion
    }
}
