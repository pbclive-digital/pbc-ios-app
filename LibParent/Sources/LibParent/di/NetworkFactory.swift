//
//  NetworkFactory.swift
//  LibParent
//
//  Created by Kavimal Wijewardana on 12/10/25.
//
import Factory
import LibNetwork

public extension Container {
    var network: Factory<NetworkProtocol> {
        Factory(self) { Network() }.shared
    }
}

