//
//  SplashViewModel.swift
//  UiSplash
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import Foundation
import Factory
import LibParent
import LibCommonData
import LibNetwork

@MainActor
class SplashViewModel: ObservableObject {
    
    @Injected(\.network) private var network: NetworkProtocol
    @Injected(\.dataStore) var dataStore: LocalDataStore
    
    @Published private(set) var uiState = SplashUiState.NONE
    
    typealias ConfigSuccessResponse = () -> Void
    typealias AuthTokenSuccessResponse = @Sendable() -> Void
    typealias FailureResponse = @Sendable(_ viewMode: AppErrorType) -> Void
    
    func fetchVersionSupportStatus(onSuccess: @escaping @Sendable () -> Void, onFailure: @escaping @Sendable () -> Void) {
        network.invokeGET(path: "/config/get/app-support/status", responseType: BaseResponse<AppVersionStatus>.self, onSuccess: { response in
            if response.body.support {
                Task { @MainActor in
                    // Fetch application config
                    self.fetchConfig()
                    
                    let authMethod = self.dataStore.retrieveObject(key: LocalDataKey.APP_AUTH_METHOD, responseType: UserAuthType.self)
                    if (authMethod == UserAuthType.APPLE) {
                        
                    } else if (authMethod == UserAuthType.GOOGLE) {
                        
                    } else {
                        self.uiState = .ON_UPDATED_REQUIRED
                    }
                }
            } else {
                //onFailure()
                Task { @MainActor in
                    self.uiState = .ON_UPDATED_REQUIRED
                }
            }
        }, onError: { netError in
            //onFailure()
            Task { @MainActor in
                self.uiState = .ON_UPDATED_REQUIRED
            }
        })
    }
    
    func fetchConfig() {
        network.invokeGET(path: "/config/get/v1", responseType: BaseResponse<Config>.self, onSuccess: { response in
            Session.shared.config = response.body
        }, onError: { netError in
            
        })
    }
    
    func requestAuthToken(onSuccess: @escaping AuthTokenSuccessResponse, onFailure: @escaping FailureResponse) {
        
        let accountId = UiActionExecutor.shared.executeAction(moduleName: "AUTH", actionName: "GET_LAST_ACC_ID")
        let accountEmail = UiActionExecutor.shared.executeAction(moduleName: "AUTH", actionName: "GET_LAST_EMAIL")

        if accountId != nil && accountEmail != nil {
        
            guard let uid = accountId else {return}
            guard let email = accountEmail else {return}
            
            network.invokeGET(path: "/auth/get/token/\(email)/\(uid)", responseType: BaseResponse<AuthToken>.self, onSuccess: { response in
                Session.shared.authToken = response.body
                
                //Fetch user data
                Task { @MainActor in
                    self.fetchUser(userId: Session.shared.authToken?.userId, onSuccess: onSuccess, onFailure: onFailure)
                }
            }, onError: { netError in
                if (netError?.errorCode == 401) {
                    Task { @MainActor in
                        self.generateAuthToken(email: email, userId: uid, onSuccess: onSuccess, onFailure: onFailure)
                    }
                } else {
                    Task { @MainActor in
                        self.invokeFailure(netError: netError, onFailure: onFailure)
                    }
                }
            })
        } else {
            onFailure(AppErrorType.UNATHORIZED)
        }
    }
    
    private func fetchUser(userId: String?, onSuccess: @escaping @Sendable AuthTokenSuccessResponse, onFailure: @escaping @Sendable FailureResponse) {
        guard let id = userId else { return }
        
        network.invokeGET(path: "/user/get/\(id)", responseType: BaseResponse<User>.self, onSuccess: { response in
            Session.shared.user = response.body
            //self.updatePushToken()
            onSuccess()
        }, onError: { netError in
            Task { @MainActor in
                self.invokeFailure(netError: netError, onFailure: onFailure)
            }
        })
    }
    
    private func generateAuthToken(email: String, userId: String?,
                                   onSuccess: @escaping AuthTokenSuccessResponse, onFailure: @escaping FailureResponse) {

        let authToken = AuthToken(email: email, userId: userId)
        
        network.invokePOST(path: "/auth/create/token", parameters: authToken, responseType: BaseResponse<AuthToken>.self, onSuccess: { response in
            print("Response Model: \(response)")
            
            Session.shared.authToken = response.body
            
            Task { @MainActor in
                // Set the sign-in flag
                self.dataStore.storeValue(key: LocalDataKey.IS_LOGIN, data: true)
                
                self.fetchUser(userId: userId, onSuccess: onSuccess, onFailure: onFailure)
            }
        }, onError: { netError in
            Task { @MainActor in
                self.invokeFailure(netError: netError, onFailure: onFailure)
            }
        })
    }
    
    private func invokeFailure(netError: NetError?, onFailure: @escaping FailureResponse) {
        guard let errorType = netError?.errorType else { return }
        switch(errorType) {
        case .HTTP_ERROR: if (netError?.errorCode == 401) {
            onFailure(AppErrorType.UNATHORIZED)
        } else {
            onFailure(AppErrorType.NO_CONNECTION)
        }
        default:
            onFailure(errorType)
        }
    }
}
