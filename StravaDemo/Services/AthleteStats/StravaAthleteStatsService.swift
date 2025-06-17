//
//  StravaAthleteService.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//

import Observation

@Observable
class StravaAthleteStatsService: AthleteStatsService {
    var apiClient: StravaAPIClient
    
    init(apiClient: StravaAPIClient) {
        self.apiClient = apiClient
    }
    
    func getAthleteStats(id: Int) async throws -> AthleteStats {
        return try await apiClient.get("/athletes/\(id)/stats")
    }
}
