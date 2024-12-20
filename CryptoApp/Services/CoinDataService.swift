//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by MacBook on 08/11/2024.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    
    private var coinSubscription : AnyCancellable?
    
    init() {
        getAllCoins()
    }
    
    
    func getAllCoins() -> Void {
        
       guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
       else { return }
       
       
       coinSubscription = NetworkingManager.download(url: url)
           .decode(type: [CoinModel].self, decoder: JSONDecoder())
           .sink(receiveCompletion: NetworkingManager.handleCompletion,
                 receiveValue:{ [weak self] coinsList in
               guard let self = self else { return }
               self.allCoins = coinsList
               self.coinSubscription?.cancel()
           }
        )

    }
}
