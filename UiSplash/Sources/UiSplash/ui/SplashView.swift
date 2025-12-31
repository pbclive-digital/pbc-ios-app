//
//  Splash.swift
//  UiSplash
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import SwiftUI
import Factory
import LibCommonUi
import LibCommonData
import LibParent
import KvColorPalette_iOS

struct SplashView: @MainActor View {
    
    @State private var wave = false
    @ObservedObject var splashViewModel = SplashViewModel()
    
    @State private var navigateToAuthView = false
    @State private var navigateToDashboardView = false
    @State private var navigateToErrorView = false
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: .center) {
                AppBackgroundView()
                
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
                
                // Retrieve support version and continue on flow
                splashViewModel.fetchVersionSupportStatus()
                
                // Async configuration fetch
                splashViewModel.fetchConfig()
                
            }.onChange(of: splashViewModel.splashUiState) { oldState, newState in
                switch(newState) {
                case .NONE:
                    print("NONE")
                case .ON_AUTH_NAVIGATION:
                    navigateToAuthView = true
                case .ON_UPDATED_REQUIRED:
                    navigateToErrorView = true
                case .ON_DASHBOARD_NAVIGATION:
                    navigateToDashboardView = true
                default:
                    print("DEFAULT")
                }
            }.animation(
                Animation.easeIn(duration: 3).repeatForever(autoreverses: false), value: wave
            )
            .navigationDestination(isPresented: $navigateToAuthView, destination: {
                UiNavigator.shared.navigateToUiModule(moduleName: "AUTH")
            })
            .navigationDestination(isPresented: $navigateToErrorView, destination: {
                AppCommonErrorView(viewMode: self.splashViewModel.errorType, navigateType: .CLOSE)
            })
        }
    }
}
