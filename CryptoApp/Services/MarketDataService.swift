//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by MacBook on 11/11/2024.
//

import Foundation
import Combine


class MarketDataService: ObservableObject {
    @Published var marketData : MarketData?
    
    
    private var cancellable: AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    func getMarketData() -> Void {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        cancellable = NetworkingManager.download(url: url)
            .decode(type: MarketDataModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] marketData in
                guard let self = self else { return }
                self.marketData = marketData.data
                self.cancellable?.cancel()
            })
    }
}
