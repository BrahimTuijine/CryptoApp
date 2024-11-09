//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by MacBook on 09/11/2024.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published  var image: UIImage? = nil
    @Published  var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let coinImageService : CoinImageServices
    
    init(coin: CoinModel) {
        self.coinImageService = CoinImageServices(coin: coin)
        getImage()
    }
    
    private func getImage() -> Void {
        isLoading = true
        coinImageService.$image
            .sink { _ in
                self.isLoading = false
            } receiveValue: { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellables)
    }
}
