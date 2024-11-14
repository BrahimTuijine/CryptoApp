//
//  ChartView.swift
//  CryptoApp
//
//  Created by MacBook on 14/11/2024.
//

import SwiftUI

struct ChartView: View {
    
    @State var isChartAnimated: Bool = false
    
    let data : [Double]
    let maxY : Double
    let minY : Double
    let lineColor : Color
    let startingDate: Date
    let endingDate: Date
    
    init(coin: CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        self.endingDate = Date(coinGeckoString:  coin.lastUpdated ?? "")
        self.startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(chartYAssis,alignment: .leading)
            
            dateLabels
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
    }
}

#Preview {
    ChartView(coin: DeveloperPreview.instance.coin)
}

extension ChartView {
   private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat( index + 1 )
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - ((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: isChartAnimated ? 1 : 0)
            .stroke(lineColor,
                    style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round)
            )
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 3)) {
                isChartAnimated = true
            }
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAssis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var dateLabels : some View {
        HStack {
            Text(startingDate.asShortDateFormatter())
            Spacer()
            Text(endingDate.asShortDateFormatter())
        }
    }
}
