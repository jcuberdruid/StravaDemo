//
//  Activity.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//
import Foundation

struct Activity: Codable {
    let resourceState: Int
    let name: String
    let distance: Double
    let movingTime: Int?
    let elapsedTime: Int?
    let totalElevationGain: Double?
    let type: String
    let sportType: String?
    let workoutType: String?
    let id: Int
    let externalId: String?
    let uploadId: Int
    let startDate: Date
    let startDateLocal: Date
    let timezone: String
    let utcOffset: Double
    let startLatlng: [Double]?
    let endLatlng: [Double]?
    let locationCity: String?
    let locationState: String?
    let locationCountry: String?
    let achievementCount: Int?
    let kudosCount: Int?
    let commentCount: Int?
    let athleteCount: Int?
    let photoCount: Int?
    let map: Map?
    let trainer: Bool
    let commute: Bool
    let manual: Bool
    let `private`: Bool
    let flagged: Bool
    let gearId: String?
    let fromAcceptedTag: Bool
    let averageSpeed: Double?
    let maxSpeed: Double?
    let averageCadence: Double?
    let averageWatts: Double?
    let weightedAverageWatts: Double?
    let kilojoules: Double?
    let hasHeartrate: Bool
    let averageHeartrate: Double?
    let maxHeartrate: Double?
    let maxWatts: Double?
    let prCount: Int?
    let totalPhotoCount: Int?
    let hasKudoed: Bool
    let sufferScore: Int?
    
    var typeIconName: String {
        switch self.type.lowercased(with: .current) {
        case "walk":
            return "figure.walk"
        case "run":
            return "figure.run"
        default:
            return "bicycle"
        }
    }
}

struct Map: Codable {
    let id: String
    let summaryPolyline: String?
    let resourceState: Int
}
