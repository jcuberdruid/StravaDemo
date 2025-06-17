//
//  StatsView.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//

import SwiftUI

struct StatsView: View {
    @Environment(AppDependencies.self) var deps
    
    @State var viewModel = StatsViewModel()
    var athlete: Athlete?
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        ScrollView {
            switch viewModel.state {
            case .loading:
                ProgressView()
                Text("Loading...")
            case .loaded:
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.labeledStats, id: \.title) { metric in
                        StatCard(metric: metric)
                    }
                }
                .padding(.horizontal)
            case .error:
                Text("Error")
            }
        }
        .onAppear {
            viewModel.injectIfNeeded(deps)
        }
        .task {
            await viewModel.refreshAthleteStats(athlete: self.athlete)
        }
        .onChange(of: deps.auth.isAuthenticated) {
            Task {
                await viewModel.refreshAthleteStats(athlete: self.athlete)
            }
        }
        .onChange(of: self.athlete?.id) {
            Task {
                await viewModel.refreshAthleteStats(athlete: self.athlete)
            }
        }
    }
   
}

/* TODO
#Preview {
    ActivityView(deps: <#T##arg#>, webAuthenticationSession: <#T##arg#>)
}
*/
