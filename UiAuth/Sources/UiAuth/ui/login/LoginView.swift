//
//  LoginView.swift
//  UiAuth
//
//  Created by Kavimal Wijewardana on 12/24/25.
//

import SwiftUI
import Factory
import KvColorPalette_iOS
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import LibParent
import LibCommonUi

struct LoginView: View {
    
    @ObservedObject var loginViewModel = LoginViewModel()
    
    @State private var isLoading: Bool = false
    @State private var navigateToDashboardView = false
    @State private var navigateToErrorView = false
    @State private var navigateToRegistrationView = false
    
    var body: some View {
        ZStack {
            AppBackgroundView()
            
            VStack {
                Spacer()
                
                VStack {
                    Image("auth.image.pbc", bundle: .module)
                        .resizable()
                        .scaledToFit()
                    
                    Text("label.pittsburgh.one", bundle: .module)
                        .font(.system(size: 32, weight: .medium))
                        .foregroundColor(Color.themePalette.quaternary)
                        .padding([.top], 10)
                    
                    Text("label.pittsburgh.two", bundle: .module)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color.themePalette.secondary)
                        .padding([.top], 4)
                }
                
                Spacer()
                
                HStack {
                    Button {
                        startSignInWithGoogle()
                    } label: {
                        AppButtonOutlineUI(buttonText: NSLocalizedString("label.login.google", bundle: .module, comment: "a comment"))
                    }
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
                Button(action: {
                    navigateToDashboardView = true
                }, label: {
                    Text("label.guest", bundle: .module)
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(Color.themePalette.secondary)
                        .padding()
                        .underline()
                })
            }
            
            if isLoading {
                AppLoadingBasic()
            }
        }
        .navigationBarHidden(true)
        .onChange(of: loginViewModel.loginUiState) { oldState, newState in
            switch(newState) {
            case .NONE:
                print("NONE")
            case .PENDING:
                isLoading = true
            case .ON_REGISTER_NAVIGATION:
                isLoading = false
                navigateToRegistrationView = true
            case .ON_DASHBOARD_NAVIGATION:
                isLoading = false
                navigateToDashboardView = true
            case .ON_ERROR:
                isLoading = false
                navigateToErrorView = true
            }
        }
        .fullScreenCover(isPresented: $navigateToDashboardView, content: {
            UiNavigator.shared.navigateToUiModule(moduleName: "DASHBOARD", entryData: nil)
        })
        .fullScreenCover(isPresented: $navigateToErrorView, content: {
            AppCommonErrorView(viewMode: .UNATHORIZED, navigateType: .BACK)
        })
        .fullScreenCover(isPresented: $navigateToRegistrationView, content: {
            RegisterView()
        })
    }
    
    private func startSignInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: UiUtil.rootViewController) { result, error in
            guard error == nil else {
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("something error")
                return
            }
            
            let credentials = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credentials, completion: { res, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let user = res?.user else { return }
                // Get the User from Google Sign In module just after sign-in success
                // let googleUser = GIDSignIn.sharedInstance.currentUser
                
                let uid = user.uid
                let email = user.email ?? "NO_EMAIL"
                
                Task { @MainActor in
                    loginViewModel.storeUserAuthMethodAsGoogle()
                    
                    if email != "NO_EMAIL" {
                        loginViewModel.fetchUserStatus(email: email, uid: uid)
                    }
                }
            })
        }
    }
}
