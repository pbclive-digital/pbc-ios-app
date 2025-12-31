//
//  UiActionExecutor.swift
//  LibParent
//
//  Created by Kavimal Wijewardana on 12/26/25.
//
import Foundation

public class UiActionExecutor {
    
    nonisolated(unsafe) public static let shared: UiActionExecutor = UiActionExecutor()
    
    @MainActor public func executeAction(moduleName: String, actionName: String) -> String? {        
        let result = UiModuleRegistry.shared.locate(moduleName: moduleName)?.invokeAction(actionName: actionName)
        
        if result != nil && result != "NIL" && result != "NO_ACTION" && result != "DEFAULT_ACTION" {
            return result
        } else {
            return nil
        }
    }
}
