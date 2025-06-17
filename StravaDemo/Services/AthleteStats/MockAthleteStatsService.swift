//
//  MockAthleteStatsService.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//


struct MockAthleteStatsService: AthleteStatsService {
    func getAthleteStats(id: Int) async throws -> AthleteStats {
        let recent = RideTotals(
            count: 7,
            distance: 158_420,
            movingTime: 21_600,
            elapsedTime: 23_100,
            elevationGain: 1_140,
            achievementCount: 9
        )
        
        let ytd = RideTotals(
            count: 82,
            distance: 1_968,
            movingTime: 255_800,
            elapsedTime: 272_300,
            elevationGain: 18_720,
            achievementCount: 107
        )
        
        let all = RideTotals(
            count: 432,
            distance: 10_935,
            movingTime: 1_412_500,
            elapsedTime: 1_502_900,
            elevationGain: 97_450,
            achievementCount: 650
        )
        
        return AthleteStats(
            biggestRideDistance: 187_350,
            recentRideTotals: recent,
            ytdRideTotals: ytd,
            allRideTotals: all
        )
    }
}
