//
//  DashboardTabView.swift
//  UiDashboard
//
//  Created by Kavimal Wijewardana on 1/1/26.
//

import SwiftUI
import LibCommonUi

struct DashboardTabView: View {
    var body: some View {
        ZStack {
            AppBackgroundView()
            
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "aqi.medium")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text("PBC")
                    }
                EventsView()
                    .tabItem {
                        Image(systemName: "aqi.medium")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text("Events")
                    }
                MeditationView()
                    .tabItem {
                        Image(systemName: "aqi.medium")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text("Meditation")
                    }
                TempleView()
                    .tabItem {
                        Image(systemName: "aqi.medium")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text("Temple")
                    }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    DashboardTabView()
}
