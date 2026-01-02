// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import SwiftUI
import LibParent

public class UiDashboard: DashboardContract {
    
    public init() {}
    
    public func retrieveEntryUI() -> AnyView {
        return AnyView(DashboardTabView())
    }
    
    public func invokeAction(actionName: String) -> String {
        return ""
    }
    
    
}
