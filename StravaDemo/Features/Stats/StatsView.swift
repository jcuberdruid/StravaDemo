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
    
    var body: some View {
        VStack {
            Text("StatsView")
            
            switch viewModel.state {
            case .loading:
                Text("Loading")
            case .loaded:
                Text("\(viewModel.athleteStats?.allRideTotals.count ?? 99)")
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
