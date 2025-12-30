//
//  Session.swift
//  LibNetwork
//
//  Created by Kavimal Wijewardana on 12/10/25.
//
import Foundation
import LibCommonData

public final class Session {
    
    nonisolated(unsafe) public static let shared = Session()
    
    public var config: Config? = nil
    public var authToken: AuthToken? = nil
    public var user: PBCUser? = nil
    
    public init() {}
}
