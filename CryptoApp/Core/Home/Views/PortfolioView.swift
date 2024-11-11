//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by MacBook on 11/11/2024.
//

import SwiftUI

struct PortfolioView: View {

    @Environment(\.dismiss) var dismiss;
    
    @EnvironmentObject private var vm : HomeViewModel
    
    @State private var selectedCoin: CoinModel? = nil
    
    @State private var quantityField: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0.0) {
                    SearchBarView()
                    
                    coinsList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
               
                
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XmarkButtonView {
                        dismiss.callAsFunction()
                    }
                }
            }
        }
       
    }
}

#Preview {
    PortfolioView()
        .environmentObject(DeveloperPreview.instance.homeVm)
}

extension PortfolioView {
    
    private var coinsList : some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10){
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                               .stroke(
                                   Color.theme.green.opacity(selectedCoin?.id == coin.id ? 1 : 0))
                        )
                        
                        
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityField) {
            return (selectedCoin?.currentPrice ?? 0) * quantity
        }
        return 0
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20.0) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrency(maximumFractionDigits: 6) ?? "")
            }
            
            Divider()
            HStack {
                Text("Amount in your portfolio:")
                Spacer()
                TextField("Ex : 1.4", text: $quantityField)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .frame(width: 100)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrency(maximumFractionDigits: 2))
            }

        }
        .animation(.none, value: UUID())
        .font(.headline)
        .padding()
    }
}
