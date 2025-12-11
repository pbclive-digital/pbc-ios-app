//
//  PBCLiveApp.swift
//  pbc-ios-app
//
//  Created by Kavimal Wijewardana on 12/8/25.
//

import SwiftUI
import UiSplash

@main
struct PBCLiveApp: App {

    @UIApplicationDelegateAdaptor(PBCLiveAppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            UiSplash().retrieveEntryUI()
        }
    }
}
