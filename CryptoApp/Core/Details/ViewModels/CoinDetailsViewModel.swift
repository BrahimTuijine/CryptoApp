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
    
    let coin: CoinModel
    let coinDetailsService : CoinDetailsService
    var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailsService = CoinDetailsService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() -> Void {
        
        coinDetailsService.$coinsDetails
            .sink { [weak self] coinDetails in
                self?.coinsDetails = coinDetails
            }
            .store(in: &cancellables)
    }
}
