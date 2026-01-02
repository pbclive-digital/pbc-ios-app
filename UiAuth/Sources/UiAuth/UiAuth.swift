// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI
import Factory
import FirebaseAuth
import GoogleSignIn
import LibParent
import LibCommonData

public class UiAuth: AuthContract {
    
    @Injected(\.dataStore) var dataStore: LocalDataStore
    
    private let firebaseAuth = Auth.auth()
    
    public init() {}
    
    public func retrieveEntryUI() -> AnyView {
        return AnyView(LoginView())
    }
    
    public func invokeAction(actionName: String) -> String {
        switch actionName {
        case "GET_LAST_ACC_ID": return getLastSignInAccId()
        case "GET_LAST_EMAIL": return getLastSignInEmail()
        case "GOOGLE_SIGN_OUT": googleSignOut()
        default:
            return "DEFAULT_ACTION"
        }
        
        return "NO_ACTION"
    }
    
    private func googleSignOut() {
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    private func getLastSignInAccId() -> String {
        let authMethod = dataStore.retrieveObject(key: LocalDataKey.APP_AUTH_METHOD, responseType: UserAuthType.self)
        if (authMethod == UserAuthType.APPLE) {
            let appleUser = Auth.auth().currentUser
            return appleUser?.uid ?? "NIL"
        } else if (authMethod == UserAuthType.GOOGLE) {
            //let googleUser = GIDSignIn.sharedInstance.currentUser
            //return googleUser?.userID ?? "NIL"
            let googleUser = Auth.auth().currentUser
            return googleUser?.uid ?? "NIL"
        }
        return "NIL"
    }
    
    private func getLastSignInEmail() -> String {
        let authMethod = dataStore.retrieveObject(key: LocalDataKey.APP_AUTH_METHOD, responseType: UserAuthType.self)
        if (authMethod == UserAuthType.APPLE) {
            let appleUser = Auth.auth().currentUser
            return appleUser?.email ?? "NIL"
        } else if (authMethod == UserAuthType.GOOGLE) {
            let googleUser = GIDSignIn.sharedInstance.currentUser
            return googleUser?.profile?.email ?? "NIL"
        }
        return "NIL"
    }
}
