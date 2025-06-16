//
//  AthleteService.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//

protocol AthleteService {
    func getAthlete() async throws -> Athlete
}
