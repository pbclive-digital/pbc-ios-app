//
//  RegisterView.swift
//  UiAuth
//
//  Created by Kavimal Wijewardana on 12/30/25.
//
import Foundation
import SwiftUI
import GoogleSignIn
import LibParent
import LibCommonUi
import LibCommonData

struct RegisterView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var registerViewModel = RegisterViewModel()
    
    @State private var isLoading = false
    
    @State private var profileUserId: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phoneNum: String = ""
    @State private var address: String = ""
    @State private var email: String = ""
    @State private var imageUrl: String = ""
    
    @State private var navigateToDashboardView = false
    @State private var navigateToErrorView = false
    
    public var body: some View {
        ZStack {
            AppBackgroundView()
            
            VStack {
                HeadingTitleViewWithX(titleText: NSLocalizedString("label.register.create", bundle: .module, comment: "a comment"), closeAction: {
                    
                    switch(registerViewModel.userAuthType) {
                    case .GOOGLE:
                        // Sign out from Google authentication
                        GIDSignIn.sharedInstance.signOut()
                    case .APPLE:
                        print("APPLE SIGN-IN")
                        // Sign out from Apple authentication
                        //try? Auth.auth().signOut()
                    case .NONE: break
                        // nothing to do
                    }
                    
                    // Set the login flag to false
                    self.registerViewModel.setIsLoginFalse()
                    
                    presentationMode.wrappedValue.dismiss()
                })
                
                Text(String(format: NSLocalizedString("phrase.create.user", bundle: .module, comment: "a comment"), email))
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(Color.themePalette.onBackground)
                    .padding()
                
                ProfilePicView(imageUrl: imageUrl, authMethod: registerViewModel.userAuthType)
                
                Text(email)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color.themePalette.onBackground)
                    .padding(8)
                
                VStack {
                    
                    AppTextFieldOutlineUI(hint: NSLocalizedString("label.first.name", bundle: .module, comment: "a comment"), valueText: $firstName)
                    
                    AppTextFieldOutlineUI(hint: NSLocalizedString("label.last.name", bundle: .module, comment: "a comment"), valueText: $lastName)
                    
                    AppTextFieldOutlineUI(hint: NSLocalizedString("label.phone.num", bundle: .module, comment: "a comment"), valueText: $phoneNum)
                    
                    AppTextFieldOutlineUI(hint: NSLocalizedString("label.address", bundle: .module, comment: "a comment"), valueText: $address)
                    
                    Spacer()
                    
                    Button(
                        action: {
                            registerViewModel.registerNewUser(
                                userId: profileUserId,
                                email: email,
                                firstName: firstName,
                                lastName: lastName,
                                address: address,
                                phone: phoneNum,
                                imageUrl: imageUrl,
                                authMethod: registerViewModel.userAuthType,
                            )
                        }, label: {
                            AppButtonFillUI(buttonText: NSLocalizedString("label.register.create", bundle: .module, comment: "a comment"))
                        }
                    )
                }
                .padding(.all, 12)
                .background(Color.themePalette.surface)
                .cornerRadius(10)
                .shadow(color: Color.themePalette.shadow, radius: 5)
                .padding([.leading, .trailing], 10)
                .padding(.top, 5)
            }
            
            if isLoading {
                AppLoadingBasic()
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            registerViewModel.populatePBCUser()
        }
        .onChange(of: registerViewModel.pbcUser) { oldUser, newUser in
            firstName = newUser.firstName
            lastName = newUser.lastName
            email = newUser.email
            imageUrl = newUser.profilePicUrl ?? ""
        }
        .onChange(of: registerViewModel.registerUiState) { olderState, newState in
            switch(newState) {
            case .NONE:
                print("NONE")
            case .PENDING:
                isLoading = true
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
    }
}

private struct ProfilePicView: View {
    
    var imageUrl: String
    var authMethod: UserAuthType
    
    init(imageUrl: String, authMethod: UserAuthType) {
        self.imageUrl = imageUrl
        self.authMethod = authMethod
    }
    
    var body: some View {
        switch(authMethod) {
        case .GOOGLE:
            AsyncImage(url: URL(string: imageUrl))
                .frame(width: 128, height: 128)
                .clipShape(Circle())
                .padding(10)
                .overlay(
                    Circle()
                        .stroke(Color.themePalette.primary, lineWidth: 2)
                )
                .padding(.all, 8)
        case .APPLE:
            AsyncImage(url: URL(string: imageUrl))
                .frame(width: 96, height: 96)
                .clipShape(Circle())
                .padding(10)
                .overlay(
                    Circle()
                        .stroke(Color.themePalette.primary, lineWidth: 2)
                )
                .padding(.all, 8)
        default:
            EmptyView()
        }
        
        
    }
}
