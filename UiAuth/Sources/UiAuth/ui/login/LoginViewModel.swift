//
//  LoginViewModel.swift
//  UiAuth
//
//  Created by Kavimal Wijewardana on 12/24/25.
//

import Foundation
import Factory
import LibNetwork
import LibParent
import LibCommonData

@MainActor
class LoginViewModel: ObservableObject {
    
    @Injected(\.network) private var network: NetworkProtocol
    @Injected(\.dataStore) var dataStore: LocalDataStore
    
    @Published private(set) var loginUiState = LoginUiState.NONE
    
    func storeUserAuthMethodAsGoogle() {
        dataStore.storeObject(key: LocalDataKey.APP_AUTH_METHOD, responseType: UserAuthType.self, data: UserAuthType.GOOGLE)
    }
    
    func fetchUserStatus(email: String?, uid: String?) {
        
        guard let userEmail = email else { return }
        guard let userId = uid else { return }
        
        network.invokeGET(path: "/auth/get/\(userEmail)/\(userId)", responseType: BaseResponse<String>.self, onSuccess: { response in
            switch response.body {
            case "REGISTERED":
                Task { @MainActor in
                    self.requestAuthToken(accountId: userId, accountEmail: userEmail)
                }
            case "UNREGISTERED":
                Task { @MainActor in
                    self.loginUiState = .ON_REGISTER_NAVIGATION
                }
            default:
                print("DEFAULT")
                Task { @MainActor in
                    self.loginUiState = .ON_ERROR
                }
                //onError("User status is not defined as expected")
            }
        }, onError: { netError in
            //onError(netError?.errorMessage ?? "")
            Task { @MainActor in
                self.loginUiState = .ON_ERROR
            }
        })
    }
    
    func requestAuthToken(accountId:String?, accountEmail: String?) {
    
        if accountId != nil && accountEmail != nil {
        
            guard let uid = accountId else {return}
            guard let email = accountEmail else {return}
            
            network.invokeGET(path: "/auth/get/token/\(email)/\(uid)", responseType: BaseResponse<AuthToken>.self, onSuccess: { response in
                Session.shared.authToken = response.body
                
                //Fetch user data
                Task { @MainActor in
                    self.fetchUser(userId: Session.shared.authToken?.userId)
                }
            }, onError: { netError in
                if (netError?.errorCode == 401) {
                    Task { @MainActor in
                        self.generateAuthToken(email: email, userId: uid)
                    }
                } else {
                    //onError(netError?.errorMessage ?? "")
                    Task { @MainActor in
                        self.loginUiState = .ON_ERROR
                    }
                }
            })
        } else {
            return
        }
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
            //onError(netError?.errorMessage ?? "")
            Task { @MainActor in
                self.loginUiState = .ON_ERROR
            }
        })
    }
    
    func fetchUser(userId: String?) {
        guard let id = userId else { return }
        
        network.invokeGET(path: "/user/get/\(id)", responseType: BaseResponse<PBCUser>.self, onSuccess: { response in
            Session.shared.user = response.body
            // Set the sign-in flag
            Task { @MainActor in
                self.dataStore.storeValue(key: LocalDataKey.IS_LOGIN, data: true)
            }
            //self.updatePushToken()
            //completion()
        }, onError: { netError in
            //onError(netError?.errorMessage ?? "")
            Task { @MainActor in
                self.loginUiState = .ON_ERROR
            }
        })
    }
}
