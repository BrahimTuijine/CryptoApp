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
    
    let coin : CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("screen initialized \(coin.name)")
    }
    
    var body: some View {
        
        Text(coin.name)
        
    }
}

#Preview {
    DetailsView(coin: DeveloperPreview.instance.coin)
        
}
