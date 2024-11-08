//
//  PreviewProvider.swift
//  CryptoApp
//
//  Created by MacBook on 07/11/2024.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev : DeveloperPreview {
        return DeveloperPreview.instance
    }
}


class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    
    private init() {}
    
    let homeVm = HomeViewModel()
    
    let coin: CoinModel = CoinModel(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
        currentPrice: 75695,
        marketCap: 1498265871749,
        fullyDilutedValuation: 1590744242803, rank: 1,
        totalVolume: 61089898876,
        high24H: 76873,
        low24H: 74444,
        priceChange24H: -162.66716408544744,
        priceChangePercentage24H: -0.21444,
        marketCapChange24H: -1268417313.2316895,
        marketCapChangePercentage24H: -0.08459,
        circulatingSupply: 19779159,
        totalSupply: 21000000,
        maxSupply: 21000000,
        ath: 76873,
        athChangePercentage: -1.22838,
        athDate: "2024-11-07T20:21:22.145Z",
        atl: 67.81,
        atlChangePercentage: 111873.81512,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: "2024-11-07T22:16:10.344Z",
        sparklineIn7D: SparklineIn7D(price: [
            70423.56523238322, 70622.9798741049, 69964.0894315405, 70029.79237067723,
            70200.64919362342, 70405.27560692604, 70179.73597236395, 70086.07109032726
        ]),
        priceChangePercentage24HInCurrency: -0.21443686614320642,
        currentHoldings: 1.5
    )

}
