//
//  NetExtension.swift
//  LibNetwork
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import Foundation

extension JSONDecoder {
    static var enumDecorder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
        return decoder
    }
}

extension JSONSerialization {

    static func toJsonString(dataObj: Codable) -> String? {
        // Convert the object to a JSON data
        if let jsonData = try? JSONEncoder().encode(dataObj) {
            // Convert the JSON data to a string
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        }

        return nil
    }
}
