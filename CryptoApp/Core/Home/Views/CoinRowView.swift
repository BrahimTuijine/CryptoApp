//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by MacBook on 07/11/2024.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    let showHoldingsCoin: Bool
    
    var body: some View {
        HStack {
            
            coinTitleAndImage
            
            if showHoldingsCoin {
                centerColumn
            }
            Spacer()
            
            rightColumn
        }
        .font(.subheadline)
        .background(
            Color.theme.background
         )
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldingsCoin: true)
            .previewLayout(.sizeThatFits)
        
        CoinRowView(coin: dev.coin, showHoldingsCoin: true)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}

extension CoinRowView {
    var coinTitleAndImage : some View {
        return Group {
            Text("\(coin.rank)")
                  .font(.caption)
                  .foregroundColor(Color.theme.secondaryText)
              
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30 )
              
              Text("\(coin.symbol)".uppercased())
                  .foregroundColor(Color.theme.accent)
                  .font(.headline)
                  .fontWeight(.semibold)
        }
    }
    
    var centerColumn : some View {
        return Group {
            Spacer()
            VStack(alignment: .trailing) {
                Text(coin.currentHoldingValue.asCurrency(maximumFractionDigits: 2))
                    .bold()
                Text((coin.currentHoldings ?? 0).asNumberString())
            }
            .foregroundColor(.theme.accent)
        }
    }
    
    var rightColumn : some View { 
        return VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrency(maximumFractionDigits: 6))
                .foregroundColor(Color.theme.accent)
                .fontWeight(.bold)
            
            if let priceChange = coin.priceChangePercentage24H {
                Text(priceChange.asPercentString())
                    .font(.headline)
                    .foregroundColor(
                        priceChange >= 0 ? Color.theme.green : Color.theme.red
                    )
            }
            
        }
    }
}


