//
//  StatisticView.swift
//  CryptoApp
//
//  Created by MacBook on 10/11/2024.
//

import SwiftUI

struct StatisticView: View {
    
    let statistic: StatisticModel
    
    let percentage: Double?
    
    init(statistic: StatisticModel) {
        self.statistic = statistic
        self.percentage = statistic.percentageChange
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4.0) {
            Text(statistic.title)
                .font(.callout)
                .foregroundColor(.secondaryText)
            
            Text(statistic.value)
                .foregroundColor(Color.theme.accent)
                .font(.headline)
            
            
                HStack {
                    Image(systemName: percentage ?? 0 >= 0 ? "triangle.fill" : "arrowtriangle.down.fill")
                        .foregroundColor(percentage ?? 0 >= 0 ? .theme.green : .theme.red)
                    Text(percentage?.asPercentString() ?? "")
                        .font(.headline)
                        .foregroundColor(
                            percentage ?? 0 >= 0 ? .theme.green : .theme.red
                        )
                }
                .opacity(percentage == nil ? 0 : 1)
            
        }
        
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    StatisticView(statistic: DeveloperPreview.instance.statistic1)
}
#Preview(traits: .sizeThatFitsLayout) {
    StatisticView(statistic: DeveloperPreview.instance.statistic2)
}
#Preview(traits: .sizeThatFitsLayout) {
    StatisticView(statistic: DeveloperPreview.instance.statistic3)
        .preferredColorScheme(.dark)
}
