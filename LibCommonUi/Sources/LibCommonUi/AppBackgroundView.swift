//
//  User.swift
//  LibCommonData
//
//  Created by Kavimal Wijewardana on 12/8/25.
//

import SwiftUI
import KvColorPalette_iOS

// MARK: - UI screen background as a common component
public struct AppBackgroundView: View {
    var topColor: Color
    var bottomColor: Color

    public init(topColor: Color = Color.themePalette.background, bottomColor: Color = Color.themePalette.background){
        self.topColor = topColor
        self.bottomColor = bottomColor
    }

    public var body: some View {
        LinearGradient(gradient: Gradient(colors: [self.topColor, self.bottomColor]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
    }
}
