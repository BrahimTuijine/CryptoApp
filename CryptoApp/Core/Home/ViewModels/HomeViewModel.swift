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
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addCoinsSubscriber()
    }
    
    func addCoinsSubscriber() -> Void {
        dataService.$allCoins.sink { [weak self] coins in
            self?.allCoins = coins
        }
        .store(in: &cancellables)
    }
}
