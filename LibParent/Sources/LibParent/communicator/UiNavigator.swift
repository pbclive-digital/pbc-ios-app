//
//  File.swift
//  
//
//  Created by Kavimal Wijewardana on 8/29/23.
//

import Foundation
import Factory
import SwiftUI

public class UiNavigator {
    
    nonisolated(unsafe) public static let shared: UiNavigator = UiNavigator()
    
    @MainActor public func navigateToUiModule(moduleName: String, entryData: String? = nil) -> AnyView? {
        return UiModuleRegistry.shared.locate(moduleName: moduleName)?.retrieveEntryUI() ?? nil
    }
}
