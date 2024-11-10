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
    
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() -> Void {
        
        // update allCoins
        $searchText
            .combineLatest(dataService.$allCoins)
            .map { (text, coins) -> [CoinModel] in
                guard !text.isEmpty else { return coins}
                
                return coins.filter({ coin in
                    let lowerName = coin.name.lowercased()
                    let lowerSymbol = coin.symbol.lowercased()
                    let lowerText = text.lowercased()
                    
                    return lowerName.contains(lowerText) || lowerSymbol.contains(lowerText)
                })
                
            }
            .sink(receiveValue: { [weak self] coins in
                self?.allCoins = coins
            })
            .store(in: &cancellables)
        
        
    }
}
