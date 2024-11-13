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
                
                Text("Overview")
                    .font(.title)
                    .bold()
                    .foregroundColor(.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                
                gridView {
                    ForEach(0..<6) { _ in
                        StatisticView(statistic: StatisticModel(title: "Title", value: "value"))
                    }
                }
                
                Text("Additional Details")
                    .font(.title)
                    .bold()
                    .foregroundColor(.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                
                gridView {
                    ForEach(0..<6) { _ in
                        StatisticView(statistic: StatisticModel(title: "Title", value: "value"))
                    }
                }
            }
            .padding()
            
        }
        .navigationTitle(vm.coin.name)
        
    }
}

#Preview {
    NavigationView {
        DetailsView(coin: DeveloperPreview.instance.coin)
    }
}

extension DetailsView {
    
    func gridView<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        LazyVGrid(
            columns: column,
            alignment: .leading,
            spacing: spacing,
            content: content
        )
    }
}
