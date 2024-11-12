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
    
    @State private var showCheckMark: Bool = false
    
    
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
                ToolbarItem(placement: .topBarTrailing) {
                    saveBtn
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
    
    private var saveBtn : some View {
        HStack {
            if showCheckMark {
                Image(systemName: "checkmark")
            } else {
                Button(action: saveBtnPressed, label: {
                    Text("Save".uppercased())
                })
                .opacity(quantityField.isEmpty ? 0 : 1)
            }
        }
        .font(.headline)
        
    }
    
    private func saveBtnPressed() -> Void {
        
        // save to portfolio
        
        
        removeSelectedCoin()
        withAnimation(.easeIn) {
            showCheckMark = true
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            showCheckMark = false
        }
        
        
    }
    
    private func removeSelectedCoin() -> Void {
        selectedCoin = nil
        quantityField = ""
    }
}
