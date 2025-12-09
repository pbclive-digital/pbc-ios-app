// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI
import LibParent

public class UiSplash: SplashContract {
    
    public init() {}
    
    public func retrieveEntryUI() -> AnyView {
        return AnyView(SplashView())
    }
    
}
