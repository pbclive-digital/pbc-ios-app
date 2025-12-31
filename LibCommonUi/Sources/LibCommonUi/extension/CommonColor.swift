//
//  CommonColor.swift
//  LibCommonUi
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import SwiftUI

extension Color {
    public static let baseColor: Color = Color("base", bundle: .module)
    
    public static let greyLight: Color = Color("grey.light", bundle: .module)
    public static let greyDark: Color = Color("grey.dark", bundle: .module)
    public static let greyIcon: Color = Color("grey.icon", bundle: .module)
}

extension ShapeStyle where Self == Color {
    public static var baseColor: Color { .baseColor }
    
    public static var greyLight: Color { .greyLight }
    public static var greyDark: Color { .greyDark }
    public static var greyIcon: Color { .greyIcon }
}
