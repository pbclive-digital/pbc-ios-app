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
import UiDashboard

class PBCModuleConfig {
    
    @Injected(\.uiSplash) var uiSplash: SplashContract
    @Injected(\.uiAuth) var uiAuth: AuthContract
    @Injected(\.uiDashboard) var uiDashboard: DashboardContract
    
    func registerUIModules() {
        UiModuleRegistry.shared.register(moduleName: "SPLASH", moduleContract: uiSplash)
        UiModuleRegistry.shared.register(moduleName: "AUTH", moduleContract: uiAuth)
        UiModuleRegistry.shared.register(moduleName: "DASHBOARD", moduleContract: uiDashboard)
    }
}
