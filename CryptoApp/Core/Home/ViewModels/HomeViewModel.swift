//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by MacBook on 08/11/2024.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var statistics: [StatisticModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var sortOptions: sortOption = .holdings
    
    private let coindataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    enum sortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    func addSubscribers() -> Void {
        
        // update allCoins
        $searchText
            .combineLatest(coindataService.$allCoins, $sortOptions)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink(receiveValue: { [weak self] coins in
                self?.allCoins = coins
            })
            .store(in: &cancellables)
        
        // update portfolioCoins
        portfolioDataService.$portfolio
            .combineLatest($allCoins)
            .map(filterPortfolioCoins)
            .sink { [weak self] coins in
                guard let self = self else {return}
                self.portfolioCoins = sortPortfolioCoinsIfNeeded(coins: coins)
            }
            .store(in: &cancellables)
        
        // update marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(marketDataToStatisticModel)
            .sink { [weak self] statistics in
                guard let self = self else {return}
                self.statistics = statistics
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func reloadData() -> Void {
        isLoading = true
        coindataService.getAllCoins()
        marketDataService.getMarketData()
        HapticsManager.notification(type: .success)
    }
    
    func filterPortfolioCoins(portfolioData: [PortfolioEntity], allCoins: [CoinModel] ) -> [CoinModel] {
        allCoins.compactMap { (coin) -> CoinModel? in
            guard let entity = portfolioData.first(where: {$0.coinId == coin.id}) else {
                return nil
            }
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    func updatePortfolio(id: String, amount: Double) -> Void {
        portfolioDataService.updatePortfolio(id: id, amount: amount)
    }
    
    private func marketDataToStatisticModel(marketData: MarketData?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats : [StatisticModel] = []
        
        guard let data = marketData else { return stats }
        
        let marketCap = StatisticModel(title: "marketCap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins
            .map({ $0.currentHoldingValue })
            .reduce(0, +)
        
        let previousValue = portfolioCoins
            .map { (coin)-> Double in
                let currentValue = coin.currentHoldingValue
                let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        
        let portfolio = StatisticModel(
            title: "Portfolio Value",
            value: portfolioValue.asCurrency(maximumFractionDigits: 2),
            percentageChange: percentageChange)
        
        stats.append(contentsOf: [marketCap, volume , btcDominance,  portfolio])
        
        return stats
    }
    
    private func filterAndSortCoins(text: String , coins: [CoinModel], sortOptions: sortOption)  -> [CoinModel] {
        
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sortOptions, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func sortCoins(sort: sortOption, coins: inout [CoinModel]) -> Void {
        switch sort {
        case .rank, .holdings: coins.sort(by: {$0.rank < $1.rank})
        case .rankReversed , .holdingsReversed: coins.sort(by: {$0.rank > $1.rank})
        case .price: coins.sort(by: {$0.currentPrice > $1.currentPrice})
        case .priceReversed: coins.sort(by: {$0.currentPrice < $1.currentPrice})
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        // will only sort by holdings or reversedholdings if needed
        switch sortOptions {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingValue > $1.currentHoldingValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingValue < $1.currentHoldingValue})
        default:
            return coins
        }
    }
    
    private func filterCoins(text: String , coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins}
        
        return coins.filter({ coin in
            let lowerName = coin.name.lowercased()
            let lowerSymbol = coin.symbol.lowercased()
            let lowerText = text.lowercased()
            
            return lowerName.contains(lowerText) || lowerSymbol.contains(lowerText)
        })
    }
}
