//
//  CoinModel.swift
//  CryptoApp
//
//  Created by MacBook on 07/11/2024.
//



// CoinGecko api info
/*
 
 URL : https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 {
 "id": "bitcoin",
 "symbol": "btc",
 "name": "Bitcoin",
 "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
 "current_price": 75695,
 "market_cap": 1498265871749,
 "market_cap_rank": 1,
 "fully_diluted_valuation": 1590744242803,
 "total_volume": 61089898876,
 "high_24h": 76873,
 "low_24h": 74444,
 "price_change_24h": -162.66716408544744,
 "price_change_percentage_24h": -0.21444,
 "market_cap_change_24h": -1268417313.2316895,
 "market_cap_change_percentage_24h": -0.08459,
 "circulating_supply": 19779159,
 "total_supply": 21000000,
 "max_supply": 21000000,
 "ath": 76873,
 "ath_change_percentage": -1.22838,
 "ath_date": "2024-11-07T20:21:22.145Z",
 "atl": 67.81,
 "atl_change_percentage": 111873.81512,
 "atl_date": "2013-07-06T00:00:00.000Z",
 "roi": null,
 "last_updated": "2024-11-07T22:16:10.344Z",
 "sparkline_in_7d": {
 "price": [
 70423.56523238322,
 70622.9798741049,
 69964.0894315405
 ]
 },
 "price_change_percentage_24h_in_currency": -0.21443686614320642
 },
*/


import Foundation

// MARK: - CoinModel
struct CoinModel: Identifiable, Codable {
    
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, fullyDilutedValuation: Double?
    let rank: Int
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case rank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(
            id: self.id,
            symbol: self.symbol,
            name: self.name,
            image: self.image,
            currentPrice: self.currentPrice,
            marketCap: self.marketCap,
            fullyDilutedValuation: self.fullyDilutedValuation,
            rank: self.rank,
            totalVolume: self.totalVolume,
            high24H: self.high24H,
            low24H: self.low24H,
            priceChange24H: self.priceChange24H,
            priceChangePercentage24H: self.priceChangePercentage24H,
            marketCapChange24H: self.marketCapChange24H,
            marketCapChangePercentage24H: self.marketCapChangePercentage24H,
            circulatingSupply: self.circulatingSupply,
            totalSupply: self.totalSupply,
            maxSupply: self.maxSupply,
            ath: self.ath,
            athChangePercentage: self.athChangePercentage,
            athDate: self.athDate,
            atl: self.atl,
            atlChangePercentage: self.atlChangePercentage,
            atlDate: self.atlDate,
            lastUpdated: self.lastUpdated,
            sparklineIn7D: self.sparklineIn7D,
            priceChangePercentage24HInCurrency: self.priceChangePercentage24HInCurrency,
            currentHoldings: amount
        )
    }
    
    var currentHoldingValue : Double {
        return (currentHoldings ?? 0) * currentPrice
    }

}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    let price: [Double]?
}
