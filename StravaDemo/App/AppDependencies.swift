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
        return StravaAthleteService(apiClient: apiClient)
    }
    
    init() {
        self.auth = AuthManager()
        self.apiClient = StravaAPIClient(auth: auth)
    }
}
