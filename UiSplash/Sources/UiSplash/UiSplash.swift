// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI
import LibParent

public class UiSplash: @MainActor SplashContract {
    
    public init() {}
    
    @MainActor public func retrieveEntryUI() -> AnyView {
        return AnyView(SplashView())
    }
    
}
