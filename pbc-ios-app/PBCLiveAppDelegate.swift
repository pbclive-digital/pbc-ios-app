//
//  PBCLiveAppDelegate.swift
//  pbc-ios-app
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import Foundation
import SwiftUI
import Factory
import LibCommonUi
import LibNetwork
import KvColorPalette_iOS

@MainActor
class PBCLiveAppDelegate: UIResponder, UIApplicationDelegate {

    @Injected(\.network) var network: NetworkProtocol
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Initiate the KvColorPallet-iOS with with app base color
        KvColorPalette.initialize(basicColor: .baseColor)
        
        // Initiate the Network
        network.initialize(netConfig: NetConfig(
            schema: "https", domain: "pbc-api-staging-1f3fe32cb947.herokuapp.com", networkHeaders: []
        ))

        return true
    }
}
