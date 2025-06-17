//
//  ContentView.swift
//  StravaDemo
//
//  Created by Jason on 6/15/25.
//

import SwiftUI

struct AppNavigationView: View {
    @Environment(AppDependencies.self) var deps
    @State var viewModel = AppNavigationViewModel()
        
    var body: some View {
            TabView {
                Tab("Activity", systemImage: "mountain.2.fill") {
                    NavigationStack {
                        ActivityView()
                            .navigationTitle(
                                viewModel.state == .loading ? "Loading..." :
                                    viewModel.state == .error ? "Error" :
                                    "Welcome \(viewModel.athlete?.firstname ?? "Athlete")"
                            )
                            .toolbar {
                                ToolbarItem(placement: .topBarTrailing) {
                                    AccountSettings(athlete: viewModel.athlete)
                                }
                            }
                    }
                }
                
                Tab("Stats", systemImage: "chart.xyaxis.line") {
                    NavigationStack {
                        StatsView(athlete: viewModel.athlete)
                            .navigationTitle(
                                viewModel.state == .loading ? "Loading..." :
                                    viewModel.state == .error ? "Error" :
                                    "\(viewModel.athlete?.firstname ?? "Athlete")’s Stats"
                            )
                            .toolbar {
                                AccountSettings(athlete: viewModel.athlete)
                            }
                    }
                }
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
