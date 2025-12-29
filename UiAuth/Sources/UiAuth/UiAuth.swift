// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI
import LibParent

public class UiAuth: AuthContract {
    
    public init() {}
    
    public func retrieveEntryUI() -> AnyView {
        return AnyView(LoginView())
    }
    
    public func invokeAction(actionName: String) -> String { "" }
}
