//
//  PBCLiveAppDelegate.swift
//  pbc-ios-app
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import Foundation
import SwiftUI
import Factory
import KvColorPalette_iOS
import Firebase
import GoogleSignIn
import LibCommonUi
import LibNetwork


@MainActor
class PBCLiveAppDelegate: UIResponder, UIApplicationDelegate {

    @Injected(\.network) var network: NetworkProtocol
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Init firebase
        FirebaseApp.configure()
        
        // Initiate the KvColorPallet-iOS with with app base color
        KvColorPalette.initialize(basicColor: .baseColor)
        
        // Initiate the Network
        let netConfig = NetConfig(schema: AppConfig.baseURLScheme, domain: AppConfig.baseURL, networkHeaders: nil)
        network.initialize(netConfig: netConfig)
        
        // Registering all Ui Modules
        PBCModuleConfig().registerUIModules()

        return true
    }
}
