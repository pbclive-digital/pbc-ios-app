// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI
import LibParent

public class UiAuth: @MainActor AuthContract {
    
    public init() {}
    
    @MainActor public func retrieveEntryUI() -> AnyView {
        return AnyView(AuthView())
    }
    
}
