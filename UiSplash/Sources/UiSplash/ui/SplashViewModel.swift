//
//  SplashViewModel.swift
//  UiSplash
//
//  Created by Kavimal Wijewardana on 12/8/25.
//
import Foundation
import Factory
import LibCommonData
import LibNetwork

class SplashViewModel: ObservableObject {
    
    @Injected(\.network) private var network: NetworkProtocol
    
    typealias ConfigSuccessResponse = () -> Void
    typealias AuthTokenSuccessResponse = () -> Void
    //typealias FailureResponse = (_ viewMode: AppErrorType) -> Void
    
    func fetchVersionSupportStatus(onSuccess: @escaping @Sendable () -> Void, onFailure: @escaping @Sendable () -> Void) {
        network.invokeGET(path: "/config/get/app-support/status", responseType: BaseResponse<AppVersionStatus>.self, onSuccess: { response in
            if response.body.support {
                onSuccess()
            } else {
                onFailure()
            }
        }, onError: { netError in
            onFailure()
        })
    }
}
