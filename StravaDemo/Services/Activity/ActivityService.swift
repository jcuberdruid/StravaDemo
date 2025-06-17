//
//  ActivityService.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//

protocol ActivityService {
    func getActivities() async throws -> [Activity]
}
