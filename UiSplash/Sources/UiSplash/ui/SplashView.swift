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
    @ObservedObject var splashViewModel = SplashViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: .center) {
                AppBackgroundView(topColor: Color.themePalette.background)
                
                Circle().fill(Color.themePalette.tertiary.opacity(wave ? 0 : 1)).frame(width: 350, height: 350).scaleEffect(self.wave ? 1 : 0)
                
                Circle().fill(Color.themePalette.tertiary.opacity(wave ? 0 : 1)).frame(width: 250, height: 250).scaleEffect(self.wave ? 1 : 0)
                
                Circle().fill(Color.themePalette.tertiary.opacity(wave ? 0 : 1)).frame(width: 150, height: 150).scaleEffect(self.wave ? 1 : 0)
                
                Image("dhamma.chakra.image")
                    .resizable()
                    .padding([.top], 10)
                    .frame(width: 200, height: 200)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }.onAppear {
                self.wave.toggle()
                
                splashViewModel.fetchVersionSupportStatus(onSuccess: {
                    print(">>>>>>>>>>>>> SUCCESS")
                }, onFailure: {
                    print(">>>>>>>>>>>>> FAILURE")
                })
                
                splashViewModel.fetchConfig()
            }.animation(
                Animation.easeIn(duration: 3).repeatForever(autoreverses: false), value: wave
            )
        }
    }
}
