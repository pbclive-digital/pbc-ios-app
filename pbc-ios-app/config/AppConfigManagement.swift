//
//  AppConfigManagement.swift
//  iAnalysis
//
//  Created by Kavimal Wijewardana on 1/25/24.
//

import Foundation
import LibCommonData

// MARK: Returns the application pointed environment according to scheme selected in build target
public enum AppEnvironment {
    static var appEnv: AppEnv {
        #if DEV
        return .dev
        #elseif STAGING
        return .staging
        #elseif PROD
        return .prod
        #endif
    }
}

// MARK: Set of build configurations available in this application
public enum AppConfig {
    public static var baseURLScheme: String {
        do {
            return try BuildConfiguration.value(for: "BASE_URL_SCHEME")
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public static var baseURL: String {
        do {
            return try BuildConfiguration.value(for: "BASE_URL")
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

// MARK: This reads the values from congfiguration file according to the scheme selected in build targets
private enum BuildConfiguration {
    enum Error: Swift.Error {
        case missingKey, invalidKey
    }
    
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }
        
        switch object {
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidKey
        }
    }
}
