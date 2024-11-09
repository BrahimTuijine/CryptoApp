//
//  CoinImageServices.swift
//  CryptoApp
//
//  Created by MacBook on 09/11/2024.
//

import Foundation
import SwiftUI
import Combine


class CoinImageServices {
    
    @Published var image: UIImage?
    
    private var imageSubscriber: AnyCancellable?
    
    init(urlImage: String) {
        getCoinImage(url: urlImage)
    }
    
    private func getCoinImage(url : String) -> Void {
        guard let url = URL(string: url) else { return }
        
        
        imageSubscriber = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue:{ [weak self] image in
                self?.image = image
                self?.imageSubscriber?.cancel()
            }
         )
    }
}
