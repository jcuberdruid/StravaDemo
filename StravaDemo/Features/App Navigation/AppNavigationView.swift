//
//  ContentView.swift
//  StravaDemo
//
//  Created by Jason on 6/15/25.
//

import SwiftUI
import AuthenticationServices

struct AppNavigationView: View {
    @Environment(AppDependencies.self) var deps
    @State var viewModel = AppNavigationViewModel()
        
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
            .navigationTitle(
                viewModel.state == .loading ? "Loading..." :
                    viewModel.state == .error ? "Error" :
                    "Welcome \(viewModel.athlete?.firstname ?? "Athlete")"
            )
        }
        .onAppear {
            viewModel.injectIfNeeded(deps)
        }
        .task {
            await viewModel.refreshAthlete()
        }
        .onChange(of: deps.auth.isAuthenticated) {
            Task {
                await viewModel.refreshAthlete()
            }
        }
    }
}

/* TODO
#Preview {
    AppNavigationView().environment(AppDependencies()) // TODO update to be mocked
}*/
