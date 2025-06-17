//
//  ActivityRow.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//
import SwiftUI

struct ActivityRow: View {
    let activity: Activity
    @State private var isOpen = false

    var body: some View {
        DisclosureGroup(isExpanded: $isOpen) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    if let locationCity = activity.locationCity {
                        Text("Location: \(locationCity)")
                    } else {
                        Text("Location: –")
                    }
                    if let movingTime = activity.movingTime {
                        Text("Moving Time \(movingTime/60) min")
                    } else {
                        Text("Moving Time –")
                    }
                    
                    Label("\(String(activity.kudosCount ?? 0))", systemImage: "hand.thumbsup.circle.fill")
                            .labelStyle(.titleAndIcon)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    if let elevGain = activity.totalElevationGain {
                        Text(String(format: "Elevation Gain %.2f m", elevGain))
                    } else {
                        Text("Elevation Gain –")
                    }
                    if let avgSpeed = activity.averageSpeed {
                        Text(String(format: "Average Speed %.2f m/s", avgSpeed))
                    } else {
                        Text("Average Speed –")
                    }
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
        } label: {
            HStack {
                Image(systemName: activity.typeIconName)
                    .foregroundStyle(.secondary)
                    .frame(minWidth: 30)
                Text(activity.name)
                    .fontWeight(.medium)
                    .lineLimit(isOpen ? nil : 1)
                Spacer()
                Text(String(format: "%.2f m", activity.distance))
                    .monospacedDigit()
            }
        }
        .animation(.easeInOut, value: isOpen)
    }
}
