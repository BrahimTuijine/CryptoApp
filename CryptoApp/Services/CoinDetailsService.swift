//
//  CoinsDetailsService.swift
//  CryptoApp
//
//  Created by MacBook on 13/11/2024.
//

import Foundation
import Combine

class CoinDetailsService: ObservableObject {
    
    @Published var coinsDetails: CoinDetailsModel?
    
    var cancellable: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinsDetails()
    }
    
    private func getCoinsDetails() -> Void {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
        else { return }
        
        cancellable = NetworkingManager.download(url: url)
            .decode(type: CoinDetailsModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] coinDetails in
                guard let self = self else { return }
                self.coinsDetails = coinDetails
                self.cancellable?.cancel()
            })
            
            
    }
}
