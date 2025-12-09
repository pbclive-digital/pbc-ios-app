//
//  CommonColor.swift
//  LibCommonUi
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import SwiftUI

extension Color {
    public static let baseColor: Color = Color("base", bundle: .module)
}

extension ShapeStyle where Self == Color {
    public static var baseColor: Color { .baseColor }
}
