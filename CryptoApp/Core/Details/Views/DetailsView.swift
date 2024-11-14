//
//  DetailsView.swift
//  CryptoApp
//
//  Created by MacBook on 13/11/2024.
//

import SwiftUI

struct DetailsLoadingView : View {
 
    @Binding var coin : CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailsView(coin: coin)
            }
        }
    }
}

struct DetailsView: View {
    
    @StateObject private var vm: CoinDetailsViewModel
    
    private let column : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinDetailsViewModel(coin: coin))
        print("screen initialized \(coin.name)")
    }
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20.0) {
                Text("")
                    .frame(height: 150)
                
                statsticTitle(title: "Overview")
                Divider()
                gridView {
                    ForEach(vm.overviewStatistics) { overview in
                        StatisticView(statistic: overview)
                    }
                }
                statsticTitle(title: "Additional Details")
                Divider()
                gridView {
                    ForEach(vm.additionalStatistics) { additional in
                        StatisticView(statistic: additional)
                    }
                }
            }
            .padding()
            
        }
        .navigationTitle(vm.coinModel.name)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                navigationBarTrailingItem
            }
        })
        
    }
}

#Preview {
    NavigationView {
        DetailsView(coin: DeveloperPreview.instance.coin)
    }
}

extension DetailsView {
    
    private var navigationBarTrailingItem : some View {
        HStack {
            Text(vm.coinModel.symbol.uppercased())
                .font(.headline)
                .foregroundColor(.theme.secondaryText)
            CoinImageView(coin: vm.coinModel)
                .frame(width: 25, height: 25)
        }
    }
    
   private func gridView<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        LazyVGrid(
            columns: column,
            alignment: .leading,
            spacing: spacing,
            content: content
        )
    }
    
    private func statsticTitle(title: String) -> some View {
        Text(title)
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}
