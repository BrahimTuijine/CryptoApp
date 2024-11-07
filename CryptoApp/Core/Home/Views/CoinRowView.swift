//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by MacBook on 07/11/2024.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    
    var body: some View {
        HStack {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            
            AsyncImage(url: URL(string: coin.image)) { image in
                image.resizable()
            } placeholder: {
                Color.red
            }
            .frame(width: 35, height: 35)
            .clipShape(.rect(cornerRadius: 25))
            
            Text("\(coin.symbol)".uppercased())
                .foregroundColor(Color.theme.accent)
                .font(.headline)
                .fontWeight(.semibold)
            
            Spacer()
            VStack(alignment: .trailing) {
                Text(coin.currentPrice, format: .currency(code: "USD"))
                    .foregroundColor(Color.theme.accent)
                    .fontWeight(.bold)
                
                Text("\(coin.priceChangePercentage24H)%")
                    .font(.title3)
                    .foregroundColor(
                        coin.priceChangePercentage24H >= 0 ? Color.theme.green : Color.theme.red
                    )
                
            }
        }
    }
}

//#Preview(traits: .sizeThatFitsLayout) {
//    CoinRowView(coin: PreviewProvider.dev.coin)
//}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin)
            .previewLayout(.sizeThatFits)
    }
}
