//
//  PBCLiveAppDelegate.swift
//  pbc-ios-app
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import Foundation
import SwiftUI
import LibCommonUi
import KvColorPalette_iOS

@MainActor
class PBCLiveAppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Initiate the KvColorPallet-iOS with with app base color
        KvColorPalette.initialize(basicColor: .baseColor)

        return true
    }
}
