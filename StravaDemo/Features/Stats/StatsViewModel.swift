//
//  StatsViewModel.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//

import Foundation
import Observation
import SwiftUI


@Observable final class StatsViewModel {
    private var deps: AppDependencies?
    func injectIfNeeded(_ deps: AppDependencies) {
        guard self.deps == nil else { return }
        self.deps = deps
    }

    enum State {
        case loading
        case loaded
        case error
    }
    var state: State = .loading
    var athleteStats: AthleteStats?
    
    var labeledStats: [LabeledStat] = []
        
    func refreshAthleteStats(athlete: Athlete?) async {
        guard let athlete = athlete else { return }
        guard let athleteStatsService = deps?.athleteStatsService else { return }
        
        do {
            self.state = .loading
            let athleteStats = try await athleteStatsService.getAthleteStats(id: athlete.id)
            self.athleteStats = athleteStats
        } catch {
            self.state = .error
        }
        
        // populate labeledStats
        
        self.labeledStats.removeAll()
        
        if let biggest_ride_distance = athleteStats?.biggestRideDistance {
            labeledStats.append(LabeledStat(
                title: "Longest ride",
                value: "\(Float(biggest_ride_distance)/1000.0) km",
                valueDescription: "Distance in km",
                systemImageName: "ruler.fill",
                tint: Color.red
            ))
        }
        
        if let distance = athleteStats?.ytdRideTotals.distance {
            labeledStats.append(LabeledStat(
                title: "Longest ride this year",
                value: "\(Float(distance)/1000.0) km",
                valueDescription: "Distance in km",
                systemImageName: "ruler.fill",
                tint: Color.red
            ))
        }
        
        if let count = athleteStats?.ytdRideTotals.count {
            labeledStats.append(LabeledStat(
                title: "Rides this year",
                value: "\(count)",
                valueDescription: "",
                systemImageName: "helmet.fill",
                tint: Color.red
            ))
        }
        
        if let elapsedTime = athleteStats?.ytdRideTotals.elapsedTime {
            labeledStats.append(LabeledStat(
                title: "Riding time this year",
                value: "\(Duration.seconds(elapsedTime).compactDurationDescription)",
                valueDescription: "",
                systemImageName: "timer",
                tint: Color.red
            ))
        }
        
        if let distance = athleteStats?.recentRideTotals.distance {
            labeledStats.append(LabeledStat(
                title: "Longest ride recently",
                value: "\(Float(distance)/1000.0) km",
                valueDescription: "Distance in km",
                systemImageName: "ruler.fill",
                tint: Color.red
            ))
        }
        
        if let count = athleteStats?.recentRideTotals.count {
            labeledStats.append(LabeledStat(
                title: "Rides recently",
                value: "\(count)",
                valueDescription: "",
                systemImageName: "helmet.fill",
                tint: Color.red
            ))
        }
        
        if let elapsedTime = athleteStats?.recentRideTotals.elapsedTime {
            labeledStats.append(LabeledStat(
                title: "Riding time recently",
                value: "\(Duration.seconds(elapsedTime).compactDurationDescription)",
                valueDescription: "",
                systemImageName: "timer",
                tint: Color.red
            ))
        }
        
        if let movingTime = athleteStats?.ytdRideTotals.movingTime {
            labeledStats.append(LabeledStat(
                title: "Moving time this year",
                value: "\(Duration.seconds(movingTime).compactDurationDescription)s",
                valueDescription: "Time in sec",
                systemImageName: "timer",
                tint: .red
            ))
        }

        if let elevationGain = athleteStats?.ytdRideTotals.elevationGain {
            labeledStats.append(LabeledStat(
                title: "Elevation gain this year",
                value: "\(elevationGain) m",
                valueDescription: "Metres climbed",
                systemImageName: "mountain.2.fill",
                tint: .red
            ))
        }

        if let trophies = athleteStats?.ytdRideTotals.achievementCount {
            labeledStats.append(LabeledStat(
                title: "Achievements this year",
                value: "\(trophies)",
                valueDescription: "",
                systemImageName: "trophy.fill",
                tint: .red
            ))
        }

        if let movingTime = athleteStats?.recentRideTotals.movingTime {
            labeledStats.append(LabeledStat(
                title: "Moving time recently",
                value: "\(Duration.seconds(movingTime).compactDurationDescription)",
                valueDescription: "Time in sec",
                systemImageName: "timer",
                tint: .red
            ))
        }

        if let elevationGain = athleteStats?.recentRideTotals.elevationGain {
            labeledStats.append(LabeledStat(
                title: "Elevation gain recently",
                value: "\(elevationGain) m",
                valueDescription: "Metres climbed",
                systemImageName: "mountain.2.fill",
                tint: .red
            ))
        }

        if let trophies = athleteStats?.recentRideTotals.achievementCount {
            labeledStats.append(LabeledStat(
                title: "Recent achievements",
                value: "\(trophies)",
                valueDescription: "",
                systemImageName: "trophy.fill",
                tint: .red
            ))
        }

        if let distance = athleteStats?.allRideTotals.distance {
            labeledStats.append(LabeledStat(
                title: "Total distance",
                value: "\(Float(distance)/1000.0) km",
                valueDescription: "Distance in km",
                systemImageName: "ruler.fill",
                tint: .red
            ))
        }

        if let count = athleteStats?.allRideTotals.count {
            labeledStats.append(LabeledStat(
                title: "Total rides",
                value: "\(count)",
                valueDescription: "",
                systemImageName: "helmet.fill",
                tint: .red
            ))
        }

        if let movingTime = athleteStats?.allRideTotals.movingTime {
            labeledStats.append(LabeledStat(
                title: "Total moving time",
                value: "\(Duration.seconds(movingTime).compactDurationDescription)",
                valueDescription: "Time in sec",
                systemImageName: "timer",
                tint: .red
            ))
        }

        if let elapsedTime = athleteStats?.allRideTotals.elapsedTime {
            labeledStats.append(LabeledStat(
                title: "Total elapsed time",
                value: "\(Duration.seconds(elapsedTime).compactDurationDescription)",
                valueDescription: "Time in sec",
                systemImageName: "timer",
                tint: .red
            ))
        }

        if let elevationGain = athleteStats?.allRideTotals.elevationGain {
            labeledStats.append(LabeledStat(
                title: "Total elevation gain",
                value: "\(elevationGain) m",
                valueDescription: "Metres climbed",
                systemImageName: "mountain.2.fill",
                tint: .red
            ))
        }

        if let trophies = athleteStats?.allRideTotals.achievementCount {
            labeledStats.append(LabeledStat(
                title: "Total achievements",
                value: "\(trophies)",
                valueDescription: "",
                systemImageName: "trophy.fill",
                tint: .red
            ))
        }
        
        
        // using c++ wrapper
        
        if let distance = athleteStats?.recentRideTotals.distance {
            let circumference = Double.pi*0.5 //assuming tire diameter of 0.5 m -- should be user editable 
            
            let revolutions = BicycleWrapper.revolutions(withDistance: Double(distance), tireCircumference: circumference)
            
            labeledStats.append(LabeledStat(
                title: "YTD Tire revolutions",
                value: "\(revolutions)",
                valueDescription: "",
                systemImageName: "tire",
                tint: .blue
            ))
            
        }
        
        self.state = .loaded
    }
}

extension Duration {
    var compactDurationDescription: String {
        return self.formatted(.units(allowed: [.hours, .minutes], width: .narrow))
    }
}
