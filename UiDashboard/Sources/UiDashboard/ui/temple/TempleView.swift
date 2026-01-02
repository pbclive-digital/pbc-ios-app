//
//  TempleView.swift
//  UiDashboard
//
//  Created by Kavimal Wijewardana on 1/1/26.
//
import SwiftUI
import LibCommonUi

struct TempleView: View {
    var body: some View {
        ZStack {
            AppBackgroundView()
            
            VStack {
                HeadingTitleView(titleText: "Temple")
                
                Spacer()
            }
        }
    }
}
