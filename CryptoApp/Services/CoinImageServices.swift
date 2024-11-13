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
    
    private let fileManager = LocalFileManager.instance
    
    private var imageSubscriber: AnyCancellable?
    
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage(coin: coin)
    }
    
    private func getCoinImage(coin: CoinModel) -> Void {
        guard let localImage = fileManager.getLocalImage(imageName: coin.id) else {
            downloadImage()
            return
        }
        self.image = localImage
    }
    
    private func downloadImage() -> Void {
        guard let url = URL(string: coin.image) else { return }

        imageSubscriber = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue:{ [weak self] image in
                
                guard let self = self,
                      let image = image
                else { return }
                
                self.image = image
                self.imageSubscriber?.cancel()
                self.fileManager.saveLocalImage(image: image, imageName: coin.id)
            }
         )
    }
}
