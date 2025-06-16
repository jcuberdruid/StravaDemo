//
//  StravaAthleteService.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//

import Observation

@Observable
class StravaAthleteService: AthleteService {
    var apiClient: StravaAPIClient
    
    init(apiClient: StravaAPIClient) {
        self.apiClient = apiClient
    }
    
    func getAthlete() async throws -> Athlete {
        return try await apiClient.get(.athlete)
    }
}
