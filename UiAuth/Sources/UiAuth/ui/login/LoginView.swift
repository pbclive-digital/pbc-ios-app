//
//  LoginView.swift
//  UiAuth
//
//  Created by Kavimal Wijewardana on 12/24/25.
//

import SwiftUI
import LibCommonUi

struct LoginView: View {
    
    @ObservedObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            AppBackgroundView()
            
            VStack {
                HeadingTitleView(titleText: NSLocalizedString("label.sign.in", bundle: .module, comment: "a comment"))
                
                Spacer()
                
                VStack {
                    Image("auth.image.pbc", bundle: .module)
                        .resizable()
                        .scaledToFit()
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}
