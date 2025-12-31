//
//  CommonContract.swift
//  LibParent
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import Foundation
import SwiftUI

@MainActor
public protocol CommonContract {
    func retrieveEntryUI() -> AnyView
    func invokeAction(actionName: String) -> String
}
