//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by MacBook on 09/11/2024.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var vm : CoinImageViewModel
    
    init(coin: CoinModel) {
         _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        if let image = vm.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else if vm.isLoading {
            ProgressView()
        } else {
            Image(systemName: "questionmark")
                .foregroundColor(.theme.secondaryText)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinImageView(coin: DeveloperPreview.instance.coin)
        .padding()
    
        
}
