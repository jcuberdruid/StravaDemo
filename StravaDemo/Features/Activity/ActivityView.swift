//
//  ActivityView.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//

import SwiftUI

struct ActivityView: View {
    @Environment(AppDependencies.self) var deps

    @State var viewModel = ActivityViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
                Text("Loading...")
            case .loaded:
                List(viewModel.activities, id: \.id) { activity in
                    ActivityRow(activity: activity)
                }
                .listStyle(.plain)
            case .error:
                Text("Error")
            }
        }
        .onAppear {
            viewModel.injectIfNeeded(deps)
        }
        .task {
            await viewModel.refreshActivities()
        }
        .onChange(of: deps.auth.isAuthenticated) {
            Task {
                await viewModel.refreshActivities()
            }
        }
    }
}

/* TODO
#Preview {
    ActivityView(deps: <#T##arg#>, webAuthenticationSession: <#T##arg#>)
}
*/
