//
//  StravaActivityService.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//

import Observation


class StravaActivityService: ActivityService {
    var apiClient: StravaAPIClient
    
    init(apiClient: StravaAPIClient) {
        self.apiClient = apiClient
    }
    
    func getActivities() async throws -> [Activity] {
        return try await apiClient.get("/athlete/activities")
    }
}
