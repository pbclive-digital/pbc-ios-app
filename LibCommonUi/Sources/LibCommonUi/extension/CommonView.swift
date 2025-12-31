//
//  CommonView.swift
//  LibCommonUi
//
//  Created by Kavimal Wijewardana on 12/30/25.
//
import SwiftUI

extension View {
    public func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
