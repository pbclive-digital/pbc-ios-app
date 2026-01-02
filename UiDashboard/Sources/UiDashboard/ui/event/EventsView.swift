//
//  EventsView.swift
//  UiDashboard
//
//  Created by Kavimal Wijewardana on 1/1/26.
//
import SwiftUI
import LibCommonUi

struct EventsView: View {
    var body: some View {
        ZStack {
            AppBackgroundView()
            
            VStack {
                HeadingTitleView(titleText: "Events")
                
                Spacer()
            }
        }
    }
}
