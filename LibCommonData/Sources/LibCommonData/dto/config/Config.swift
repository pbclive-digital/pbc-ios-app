//
//  Config.swift
//  LibCommonData
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import Foundation

public struct Config: Codable, Sendable {
    public var dashboardEventCount: Int = 2
    public var dailyQuotesCount: Int = 5
    public var residentMonkList: Array<User> = []
}
