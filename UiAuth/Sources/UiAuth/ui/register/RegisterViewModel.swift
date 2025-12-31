//
//  RegisterViewModel.swift
//  UiAuth
//
//  Created by Kavimal Wijewardana on 12/30/25.
//
import Foundation
import Factory
import FirebaseAuth
import GoogleSignIn
import LibParent
import LibCommonData
import LibNetwork

@MainActor
class RegisterViewModel: ObservableObject {
    
    @Injected(\.network) private var network: NetworkProtocol
    @Injected(\.dataStore) var dataStore: LocalDataStore
    
    @Published private(set) var registerUiState = RegisterUiState.NONE
    @Published private(set) var registerErrorType = AuthErrorType.NONE
    
    @Published private(set) var pbcUser = PBCUser()
    @Published private(set) var userAuthType: UserAuthType = .NONE
    
    func setIsLoginFalse() {
        dataStore.storeValue(key: LocalDataKey.IS_LOGIN, data: false)
    }
    
    func populatePBCUser() {
        let authType = dataStore.retrieveObject(key: LocalDataKey.APP_AUTH_METHOD, responseType: UserAuthType.self)
        
        switch(authType) {
        case .GOOGLE:
            // Get the User from Google Sign In module just after sign-in success
            let googleUser = GIDSignIn.sharedInstance.currentUser
            
            pbcUser.firstName = googleUser?.profile?.givenName ?? ""
            pbcUser.lastName = googleUser?.profile?.familyName ?? ""
            pbcUser.email = googleUser?.profile?.email ?? ""
            pbcUser.address = ""
            pbcUser.phoneNumber = ""
            pbcUser.profilePicUrl = googleUser?.profile?.imageURL(withDimension: 128)?.absoluteString ?? ""
            pbcUser.userType = String(describing: authType)
            pbcUser.id = googleUser?.userID ?? ""
            
            userAuthType = .GOOGLE
        case .APPLE:
            userAuthType = .APPLE
        default:
            userAuthType = .NONE
        }
    }
    
    func registerNewUser(userId: String, email: String, firstName: String, lastName: String, address: String, phone: String?, imageUrl: String, authMethod: UserAuthType) {
        
        let newUser = PBCUser(id: userId, email: email, firstName: firstName, lastName: lastName, phoneNum: phone, profilePicUrl: imageUrl, address: address, userType: String(describing: authMethod), isResidentMonk: false, userAuthType: String(describing: authMethod))
    
        network.invokePOST(path: "/user/create", parameters: newUser, responseType: BaseResponse<String>.self, onSuccess: { response in
            Session.shared.user = newUser
            
            Task { @MainActor in
                self.generateAuthToken(email: newUser.email, userId: newUser.id)
            }
        }, onError: { netError in
            Task { @MainActor in
                self.registerUiState = .ON_ERROR
                self.registerErrorType = AuthErrorType.HTTP_ERROR
            }
        })
    }
    
    func generateAuthToken(email: String, userId: String?) {
        
        let authToken = AuthToken(email: email, userId: userId)
        
        network.invokePOST(path: "/auth/create/token", parameters: authToken, responseType: BaseResponse<AuthToken>.self, onSuccess: { response in
            Session.shared.authToken = response.body
            
            Task { @MainActor in
                // Set the sign-in flag
                self.dataStore.storeValue(key: LocalDataKey.IS_LOGIN, data: true)
                
                self.fetchUser(userId: userId)
            }
        }, onError: { netError in
            Task { @MainActor in
                self.registerUiState = .ON_ERROR
                self.registerErrorType = AuthErrorType.HTTP_ERROR
            }
        })
    }
    
    func fetchUser(userId: String?) {
        guard let id = userId else { return }
        
        network.invokeGET(path: "/user/get/\(id)", responseType: BaseResponse<PBCUser>.self, onSuccess: { response in
            Session.shared.user = response.body
            // Set the sign-in flag
            Task { @MainActor in
                self.registerUiState = .ON_DASHBOARD_NAVIGATION
            }
            //self.updatePushToken()
        }, onError: { netError in
            Task { @MainActor in
                self.registerUiState = .ON_ERROR
                self.registerErrorType = AuthErrorType.HTTP_ERROR
            }
        })
    }
}
