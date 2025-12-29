//
//  Splash.swift
//  UiSplash
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import SwiftUI
import Factory
import LibCommonUi
import LibParent
import KvColorPalette_iOS

struct SplashView: @MainActor View {
    
    @State private var wave = false
    @ObservedObject var splashViewModel = SplashViewModel()
    
    @State private var navigateToAuthView = false
    
    @Injected(\.dataStore) var dataStore: LocalDataStore
    
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
                
                splashViewModel.fetchVersionSupportStatus(onSuccess: {
                    Task { @MainActor in
                        navigateToAuthView = true
                    }
                }, onFailure: {
                    print(">>>>>>>>>>>>> FAILURE")
                })
                    
                splashViewModel.fetchConfig()
            }.animation(
                Animation.easeIn(duration: 3).repeatForever(autoreverses: false), value: wave
            )
            .navigationDestination(isPresented: $navigateToAuthView, destination: {
                UiNavigator.shared.navigateToUiModule(moduleName: "AUTH")
            })
        }
    }
    
    private func requestAuthTokenAndContinue() {
        // Application already have a sign-in user.
        if dataStore.retrieveBool(key: LocalDataKey.IS_LOGIN) {
            // Fetch auth Token and User
            splashViewModel.requestAuthToken(onSuccess: {
                //navigateToDashboardView = true
            }, onFailure: { viewMode in
                //navigateToErrorViewType = viewMode
                //navigateToErrorView = true
            })
        } else {
            navigateToAuthView = true
        }
    }
}
