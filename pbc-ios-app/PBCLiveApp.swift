//
//  PBCLiveApp.swift
//  pbc-ios-app
//
//  Created by Kavimal Wijewardana on 12/8/25.
//

import SwiftUI
import Factory
import LibParent

@main
struct PBCLiveApp: App {

    @UIApplicationDelegateAdaptor(PBCLiveAppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            UiNavigator.shared.navigateToUiModule(moduleName: "SPLASH")
        }
    }
}
