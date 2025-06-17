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
        return StravaAthleteService(apiClient: apiClient) // will be mock
    }
    var athleteStatsService: AthleteStatsService {
        if auth.isAuthenticated {
            return StravaAthleteStatsService(apiClient: apiClient)
        }
        return StravaAthleteStatsService(apiClient: apiClient) // will be mock
    }
    
    var activityService: ActivityService {
        if auth.isAuthenticated {
            return StravaActivityService(apiClient: apiClient)
        }
        return StravaActivityService(apiClient: apiClient) // will be mock
    }
    
    init() {
        self.auth = AuthManager()
        self.apiClient = StravaAPIClient(auth: auth)
    }
}
