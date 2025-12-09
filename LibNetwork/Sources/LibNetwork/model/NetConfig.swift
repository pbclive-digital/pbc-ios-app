//
//  NetConfig.swift
//  LibNetwork
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import Foundation

public struct NetConfig {
    let schema: String
    let domain: String
    let networkHeaders: Array<NetHeader> = Array()

    public init(schema: String, domain: String, networkHeaders: Array<NetHeader>?) {
        self.schema = schema
        self.domain = domain
    }
}

public struct NetHeader {
    let headerKey: String
    let header: String

    public init(headerKey: String, header: String) {
        self.headerKey = headerKey
        self.header = header
    }
}
