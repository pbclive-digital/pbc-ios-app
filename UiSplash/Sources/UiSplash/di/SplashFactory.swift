//
//  SplashFactory.swift
//  UiSplash
//
//  Created by Kavimal Wijewardana on 12/25/25.
//
import Factory
import LibParent

public extension Container {
    var uiSplash: Factory<SplashContract> {
        Factory(self) { MainActor.assumeIsolated { UiSplash() }}.shared
    }
}
