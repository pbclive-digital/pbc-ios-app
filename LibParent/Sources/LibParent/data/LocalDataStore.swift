//
//  LocalDataStore.swift
//  LibParent
//
//  Created by Kavimal Wijewardana on 12/26/25.
//
public protocol LocalDataStore {
    func storeValue(key: String, data: Any)
    func storeObject<T: Codable>(key: String, responseType: T.Type, data: T)
    func clearValue(key: String)
    func retrieveString(key: String) -> String?
    func retrieveBool(key: String) -> Bool
    func retrieveInt(key: String) -> Int
    func retrieveFloat(key: String) -> Float
    func retrieveObject<T: Codable>(key: String, responseType: T.Type) -> T?
}
