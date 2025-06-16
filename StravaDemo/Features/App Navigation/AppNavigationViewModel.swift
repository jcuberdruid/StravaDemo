//
//  AppNavigationViewModel.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//

import Observation

@Observable final class AppNavigationViewModel {
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
    var athlete: Athlete?
    
    func refreshAthlete() async {
        guard let athleteService = deps?.athleteService else { return }
        do {
            self.state = .loading
            let athlete = try await athleteService.getAthlete()
            self.state = .loaded
            self.athlete = athlete
        } catch(let e) {
            self.state = .error
        }
    }
}
