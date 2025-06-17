//
//  MockAthleteService.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//


import Foundation

struct MockAthleteService: AthleteService {
    func getAthlete() async throws -> Athlete {
        return Athlete(
            id: 42,
            firstname: "Demo",
            lastname: "",
            profile: ""
        )
    }
}
