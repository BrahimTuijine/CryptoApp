//
//  CoinDetailsViewModel.swift
//  CryptoApp
//
//  Created by MacBook on 13/11/2024.
//

import Foundation
import Combine

class CoinDetailsViewModel: ObservableObject {
    @Published var coinsDetails: CoinDetailsModel?
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    @Published var description: String?
    @Published var websiteUrl: String?
    @Published var redditUrl: String?
    
    @Published var coinModel: CoinModel
    let coinDetailsService : CoinDetailsService
    var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinModel = coin
        self.coinDetailsService = CoinDetailsService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() -> Void {
        
        coinDetailsService.$coinsDetails
            .combineLatest($coinModel)
            .map(detailsToStatistics)
            .sink { [weak self] returnedArrays in
                guard let self = self else {return}
                self.overviewStatistics = returnedArrays.overview
                self.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)
        
        coinDetailsService.$coinsDetails
            .sink { [weak self] coinDetails in
                guard let self = self else {return}
                self.description = coinDetails?.readableDescription
                self.websiteUrl = coinDetails?.links?.homepage?.first
                self.redditUrl = coinDetails?.links?.subredditURL
               
            }
            .store(in: &cancellables)
    }
    
    private func detailsToStatistics(coinDetail: CoinDetailsModel?, coin: CoinModel)
    -> (overview: [StatisticModel], additional: [StatisticModel])
    {
        // overview
        let overviewArray = createOverviewArray(coin: coin)
        // additional
        let additionalArray = createAdditionalArray(coinDetail: coinDetail, coin: coin)

        return (overviewArray, additionalArray)
    }
    
   private func createOverviewArray(coin: CoinModel) -> [StatisticModel] {
        let priceStat : StatisticModel  = {
            let price = coin.currentPrice.asCurrency(maximumFractionDigits: 6)
            let priceChange = coin.priceChangePercentage24H
            return StatisticModel(title: "CurrentPrice", value: price, percentageChange: priceChange)
        }()
        
        let marketCapStat = {
            let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
            let marketCapChange = coin.marketCapChangePercentage24H
            return StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapChange)
        }()
        
        let rank = "\(coin.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "S" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        return [priceStat, marketCapStat, rankStat, volumeStat]
    }
    
    private func createAdditionalArray(coinDetail: CoinDetailsModel?, coin: CoinModel) -> [StatisticModel] {
        let high = coin.high24H?.asCurrency(maximumFractionDigits: 6) ?? "n/a"
        let highStat = StatisticModel(title: "24h High",value: high)
        
        let low = coin.low24H?.asCurrency(maximumFractionDigits: 6) ?? "n/a"
        let lowStat = StatisticModel(title:  "24h Low", value: low)
        
        let priceChange = coin.priceChange24H?.asCurrency(maximumFractionDigits: 6) ?? "n/a"
        let pricePercentChange2 = coin.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange2)
        
        let marketCapChange = "S" + (coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coin.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange2)
        
        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetail?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title:"Hashing Algorithm", value: hashing)
        
        return [ highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat]
    }
    
}
