//
//  StatCard.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//
import SwiftUI

struct StatCard: View {
    let metric: LabeledStat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Icon
            Image(systemName: metric.systemImageName)
                .font(.title2)
                .foregroundStyle(metric.tint)
                .aspectRatio(1, contentMode: .fit)
                .frame(height: 32)
            
            Text(metric.title)
                .font(.footnote)
                .foregroundStyle(.secondary)
            
            Text(metric.value)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.primary)
                .minimumScaleFactor(0.7)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, minHeight: 100, alignment: .topLeading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.regularMaterial)
        )
    }
}
