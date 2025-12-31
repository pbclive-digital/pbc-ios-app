//
//  File.swift
//  
//
//  Created by Kavimal Wijewardana on 9/9/23.
//

import Foundation
import SwiftUI
import UIKit

public final class UiUtil {
    
    /**
     This method is to return rootViewController from the application when it needs on SwifUI.
     @return rootViewController
     */
    @MainActor public static var rootViewController: UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
