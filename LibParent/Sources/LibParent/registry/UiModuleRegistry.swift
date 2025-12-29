//
//  UiModuleRegistry.swift
//  LibParent
//
//  Created by Kavimal Wijewardana on 12/25/25.
//
import Foundation

public class UiModuleRegistry {
    
    nonisolated(unsafe) public static let shared = UiModuleRegistry()
    
    private var moduleRegistry = [String: any CommonContract]()
       
    public func register(moduleName: String, moduleContract: any CommonContract) {
        moduleRegistry[moduleName] = moduleContract
    }
    
    public func locate(moduleName: String) -> (any CommonContract)? {
        return moduleRegistry[moduleName] ?? nil
    }
}
