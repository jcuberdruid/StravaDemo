//
//  StatsViewModel.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//

import Observation

@Observable final class StatsViewModel {
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
    var athleteStats: AthleteStats?
        
    func refreshAthleteStats(athlete: Athlete?) async {
        guard let athlete = athlete else { return }
        guard let athleteStatsService = deps?.athleteStatsService else { return }
        
        do {
            self.state = .loading
            let athleteStats = try await athleteStatsService.getAthleteStats(id: athlete.id)
            self.state = .loaded
            self.athleteStats = athleteStats
        } catch {
            self.state = .error
        }
    }
}
