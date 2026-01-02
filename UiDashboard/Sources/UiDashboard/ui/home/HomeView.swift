//
//  HomeView.swift
//  UiDashboard
//
//  Created by Kavimal Wijewardana on 1/1/26.
//

import SwiftUI
import LibParent
import LibCommonUi

struct HomeView: View {
    var body: some View {
        ZStack {
            AppBackgroundView()
            
            VStack {
                HeadingTitleView(titleText: "Home")
                
                Spacer()
            }
        }
    }
}
