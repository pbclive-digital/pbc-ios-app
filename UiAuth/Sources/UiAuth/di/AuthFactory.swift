//
//  AuthFactory.swift
//  UiAuth
//
//  Created by Kavimal Wijewardana on 12/25/25.
//
import Factory
import LibParent

public extension Container {
    var uiAuth: Factory<AuthContract> {
        Factory(self) { MainActor.assumeIsolated { UiAuth() }}.shared
    }
}
