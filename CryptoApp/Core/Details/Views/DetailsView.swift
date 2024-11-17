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
    @State private var showMore: Bool = false
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinDetailsViewModel(coin: coin))
    }
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                ChartView(coin: vm.coinModel)
                    .padding(.top )
                VStack(spacing: 20.0) {
                    statsticTitle(title: "Overview")
                    Divider()
                    
                    descriptionSection
                    
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
                    
                    webSiteSection
                }
                .padding()
            }
            
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
    
    private var descriptionSection : some View {
        VStack(alignment: .leading) {
            if let description = vm.description,
               !description.isEmpty {
                Text(description)
                .lineLimit(showMore ? nil : 3)
                .font(.callout)
                .foregroundColor(.theme.secondaryText)
                    
            Text(showMore ? "Less" : "Read more...")
                .font(.caption)
                .foregroundColor(.blue)
                .bold()
                .underline()
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showMore.toggle()
                    }
                }
                
            }
        }
    }
    
    private var webSiteSection : some View {
        VStack(alignment: .leading, spacing: 10.0) {
            if let websiteString = vm.websiteUrl,
               let url = URL(string: websiteString) {
                Link("Website", destination: url)
            }
            
            if let websiteString = vm.redditUrl,
               let url = URL(string: websiteString) {
                Link("Reddit", destination: url)
            }
        }
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
    
}
