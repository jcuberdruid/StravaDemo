//
//  ActivityViewModel.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//


import Observation

@Observable final class ActivityViewModel {
    private var deps: AppDependencies?
    func injectIfNeeded(_ deps: AppDependencies) {
        guard self.deps == nil else { return }
        self.deps = deps
    }

    enum State {
        case loading
        case loaded
        case error
    }
    var state: State = .loading
    var activities: [Activity] = []
        
    func refreshActivities() async {

        guard let activityService = deps?.activityService else { return }
        
        do {
            self.state = .loading
            let activities = try await activityService.getActivities()
            self.state = .loaded
            self.activities = activities
        } catch {
            self.state = .error
        }
    }
}
