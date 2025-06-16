//
//  ContentView.swift
//  StravaDemo
//
//  Created by Jason on 6/15/25.
//

import SwiftUI
import AuthenticationServices

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                Tab("Activity", systemImage: "mountain.2.fill") {
                    ActivityView()
                }
                
                Tab("Stats", systemImage: "chart.xyaxis.line") {
                    StatsView()
                }
            }
            .navigationTitle("Strava Demo")
        }
    }
}

#Preview {
    ContentView().environment(AppDependencies()) // TODO update to be mocked
}
