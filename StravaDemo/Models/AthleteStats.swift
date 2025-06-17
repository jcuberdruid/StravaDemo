//
//  AthleteStats.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//

struct AthleteStats: Codable {
    let biggestRideDistance: Float?
    let recentRideTotals: RideTotals
    let ytdRideTotals: RideTotals
    let allRideTotals: RideTotals
}

struct RideTotals: Codable {
    let count: Int
    let distance: Int
    let movingTime: Int
    let elapsedTime: Int
    let elevationGain: Float
    let achievementCount: Int?
}
