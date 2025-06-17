//
//  AthleteService.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//

protocol AthleteStatsService {
    func getAthleteStats(id: Int) async throws -> AthleteStats
}
