//
//  PBCModuleConfig.swift
//  pbc-ios-app
//
//  Created by Kavimal Wijewardana on 12/25/25.
//
import Factory
import LibParent
import UiSplash
import UiAuth

class PBCModuleConfig {
    
    @Injected(\.uiSplash) var uiSplash: SplashContract
    @Injected(\.uiAuth) var uiAuth: AuthContract
    
    func registerUIModules() {
        UiModuleRegistry.shared.register(moduleName: "SPLASH", moduleContract: uiSplash)
        UiModuleRegistry.shared.register(moduleName: "AUTH", moduleContract: uiAuth)
    }
}
