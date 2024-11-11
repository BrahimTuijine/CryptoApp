//
//  CoinLogoView.swift
//  CryptoApp
//
//  Created by MacBook on 11/11/2024.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(.theme.accent)
                .lineLimit(1)
            
            Text(coin.name.uppercased())
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                
        }
        
        
    }
}

#Preview {
    CoinLogoView(coin: DeveloperPreview.instance.coin)
}
