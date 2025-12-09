//
//  Splash.swift
//  UiSplash
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import SwiftUI
import LibCommonUi
import KvColorPalette_iOS

struct SplashView: View {
    @State private var wave = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppBackgroundView(topColor: Color.themePalette.background)
                
                Circle().fill(Color.themePalette.quaternary.opacity(wave ? 0 : 1)).frame(width: 350, height: 350).scaleEffect(self.wave ? 1 : 0)
                
                Circle().fill(Color.themePalette.quaternary.opacity(wave ? 0 : 1)).frame(width: 250, height: 250).scaleEffect(self.wave ? 1 : 0)
                
                Circle().fill(Color.themePalette.quaternary.opacity(wave ? 0 : 1)).frame(width: 150, height: 150).scaleEffect(self.wave ? 1 : 0)
                
                Image("dhamma.chakra.image")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }.onAppear {
                self.wave.toggle()
            }.animation(
                Animation.easeIn(duration: 3).repeatForever(autoreverses: false), value: wave
            )
        }
    }
}
