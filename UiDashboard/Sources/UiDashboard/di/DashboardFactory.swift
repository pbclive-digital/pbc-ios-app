//
//  DashboardFactory.swift
//  UiDashboard
//
//  Created by Kavimal Wijewardana on 1/1/26.
//
import Factory
import LibParent

public extension Container {
    var uiDashboard: Factory<DashboardContract> {
        Factory(self) { MainActor.assumeIsolated { UiDashboard() } }.shared
    }
}
