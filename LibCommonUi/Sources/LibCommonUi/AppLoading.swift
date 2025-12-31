//
//  SwiftUIView.swift
//  
//
//  Created by Kavimal Wijewardana on 12/11/23.
//

import SwiftUI
import KvColorPalette_iOS

// MARK: - UI component for loading view
public struct AppLoadingBasic: View {
    
    public init() {}
    
    public var body: some View {
        ZStack{
            Color(.black)
                .ignoresSafeArea()
                .opacity(0.6)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.themePalette.quaternary))
                .scaleEffect(2)
        }
    }
}

#Preview {
    AppLoadingBasic()
}
