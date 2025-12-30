//
//  SplashViewModel.swift
//  UiSplash
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import Foundation
import Factory
import GoogleSignIn
import FirebaseAuth
import LibParent
import LibCommonData
import LibNetwork

@MainActor
class SplashViewModel: ObservableObject {
    
    @Injected(\.network) private var network: NetworkProtocol
    @Injected(\.dataStore) var dataStore: LocalDataStore
    
    @Published private(set) var splashUiState = SplashUiState.NONE
    @Published private(set) var errorType = AppErrorType.GENERAL
    
    func fetchVersionSupportStatus() {
        network.invokeGET(path: "/config/get/app-support/status", responseType: BaseResponse<AppVersionStatus>.self, onSuccess: { response in
            if response.body.support {
                Task { @MainActor in
                    let authMethod = self.dataStore.retrieveObject(key: LocalDataKey.APP_AUTH_METHOD, responseType: UserAuthType.self)
                    if (authMethod == UserAuthType.APPLE) {
                        
                    } else if (authMethod == UserAuthType.GOOGLE) {
                        await self.checkPreviousGoogleSignIn()
                    } else {
                        self.splashUiState = .ON_AUTH_NAVIGATION
                    }
                }
            } else {
                Task { @MainActor in
                    self.splashUiState = .ON_UPDATED_REQUIRED
                    self.errorType = .NEED_UPDATE
                }
            }
        }, onError: { netError in
            Task { @MainActor in
                self.splashUiState = .ON_UPDATED_REQUIRED
            }
        })
    }
    
    func fetchConfig() {
        network.invokeGET(path: "/config/get/v1", responseType: BaseResponse<Config>.self, onSuccess: { response in
            Session.shared.config = response.body
        }, onError: { netError in })
    }
    
    private func checkPreviousGoogleSignIn() async {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // Application don't have sign-in user
                Task { @MainActor in
                    self.splashUiState = SplashUiState.ON_AUTH_NAVIGATION
                }
            } else {
                Task { @MainActor in
                    if self.dataStore.retrieveBool(key: LocalDataKey.IS_LOGIN) {
                        self.requestAuthToken()
                    } else {
                        self.splashUiState = .ON_AUTH_NAVIGATION
                    }
                }
            }
        }
    }
    
    private func requestAuthToken() {
        
        let accountId = UiActionExecutor.shared.executeAction(moduleName: "AUTH", actionName: "GET_LAST_ACC_ID")
        let accountEmail = UiActionExecutor.shared.executeAction(moduleName: "AUTH", actionName: "GET_LAST_EMAIL")

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
                    Task { @MainActor in
                        self.invokeFailure(netError: netError)
                    }
                }
            })
        } else {
            Task { @MainActor in
                self.splashUiState = SplashUiState.ON_ERROR
                self.errorType = .UNATHORIZED
            }
        }
    }
    
    private func fetchUser(userId: String?) {
        guard let id = userId else { return }
        
        network.invokeGET(path: "/user/get/\(id)", responseType: BaseResponse<PBCUser>.self, onSuccess: { response in
            Session.shared.user = response.body
            //self.updatePushToken()
            Task { @MainActor in
                self.splashUiState = SplashUiState.ON_DASHBOARD_NAVIGATION
            }
        }, onError: { netError in
            Task { @MainActor in
                self.invokeFailure(netError: netError)
            }
        })
    }
    
    private func generateAuthToken(email: String, userId: String?) {

        let authToken = AuthToken(email: email, userId: userId)
        
        network.invokePOST(path: "/auth/create/token", parameters: authToken, responseType: BaseResponse<AuthToken>.self, onSuccess: { response in
            print("Response Model: \(response)")
            
            Session.shared.authToken = response.body
            
            Task { @MainActor in
                // Set the sign-in flag
                self.dataStore.storeValue(key: LocalDataKey.IS_LOGIN, data: true)
                
                self.fetchUser(userId: userId)
            }
        }, onError: { netError in
            Task { @MainActor in
                self.invokeFailure(netError: netError)
            }
        })
    }
    
    private func invokeFailure(netError: NetError?) {
        guard let errorType = netError?.errorType else { return }
        switch(errorType) {
        case .HTTP_ERROR: if (netError?.errorCode == 401) {
            //onFailure(AppErrorType.UNATHORIZED)
            Task { @MainActor in
                self.splashUiState = SplashUiState.ON_ERROR
                self.errorType = .UNATHORIZED
            }
        } else {
            Task { @MainActor in
                self.splashUiState = SplashUiState.ON_ERROR
                self.errorType = .NO_CONNECTION
            }
        }
        default:
            self.splashUiState = SplashUiState.ON_ERROR
            self.errorType = .GENERAL
        }
    }
}
