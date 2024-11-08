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
    
    
   private func getAllCoins() -> Void {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") 
       else { return }
        
        
       coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
           .tryMap { output -> Data in
               
               guard let response = output.response as? HTTPURLResponse,
                     response.statusCode >= 200 && response.statusCode < 300
               else {
                   throw URLError(.badServerResponse)
               }
               return output.data
           }
           .receive(on: DispatchQueue.main)
           .decode(type: [CoinModel].self, decoder: JSONDecoder())
           .sink { completion  in
               switch completion {
               case .finished :
                   break
               case .failure(let error) :
                   print(error)
               }
           } receiveValue:{ [weak self] coinsList in
               self?.allCoins = coinsList
               self?.coinSubscription?.cancel()
           }

    }
}
