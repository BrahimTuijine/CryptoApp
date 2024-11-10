//
//  HomeView.swift
//  CryptoApp
//
//  Created by MacBook on 07/11/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio: Bool = false
    
    @EnvironmentObject private var vm : HomeViewModel
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            VStack {
                homeHeader
                
                SearchBarView()
                
                columnTitle
                
                if !showPortfolio {
                    allCoinsList(coins: vm.allCoins)
                    .transition(.move(edge: .leading))
                }else {
                    allCoinsList(coins: vm.portfolioCoins)
                    .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
                
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
        .environmentObject(dev.homeVm)
    }
}


extension HomeView {
    private var homeHeader: some View {
        HStack { 
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: UUID())
                .background(
                    CircleBtnAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text( showPortfolio ? "Portfolio" : "Live Price")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
                .animation(.none, value: UUID())
               
            
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(.degrees(showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private func allCoinsList(coins: [CoinModel]) -> some View {
        List {
            ForEach(coins) { coin in
                CoinRowView(coin: coin, showHoldingsCoin: showPortfolio)
            }
        }
        .listStyle(.plain)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 10, trailing: 0))
    }
    
    private var columnTitle : some View {
        HStack {
            Text("Coins")
            if showPortfolio {
                Group {
                    Spacer()
                    Text("Holdings")
                }
            }
            Spacer()
            Text("Price")
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .padding([.leading, .top, .trailing])
    }
    
}
