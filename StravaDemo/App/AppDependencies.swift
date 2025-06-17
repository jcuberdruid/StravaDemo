//
//  AppDependencies.swift
//  StravaDemo
//
//  Created by Jason on 6/15/25.
//
import Observation

@Observable final class AppDependencies {
    let auth: AuthManager
    let apiClient: StravaAPIClient
    
    var athleteService: AthleteService {
        if auth.isAuthenticated {
            return StravaAthleteService(apiClient: apiClient)
        }
        return MockAthleteService()
    }
    var athleteStatsService: AthleteStatsService {
        if auth.isAuthenticated {
            return StravaAthleteStatsService(apiClient: apiClient)
        }
        return MockAthleteStatsService()
    }
    
    var activityService: ActivityService {
        if auth.isAuthenticated {
            return StravaActivityService(apiClient: apiClient)
        }
        return MockActivityService()
    }
    
    init() {
        self.auth = AuthManager()
        self.apiClient = StravaAPIClient(auth: auth)
    }
}
