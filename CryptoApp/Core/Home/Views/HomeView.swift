//
//  HomeView.swift
//  CryptoApp
//
//  Created by MacBook on 07/11/2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm : HomeViewModel
    
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioSheet: Bool = false
    @State private var showSettingSheet: Bool = false
    @State private var selectedCoin: CoinModel?
    @State private var showDetailsView: Bool = false
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioSheet, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
            
            // content layer
            VStack {
                homeHeader
                
                HomeStatView(showPortfolio: $showPortfolio)
                
                SearchBarView()
                
                columnTitle
                
                if !showPortfolio {
                    allCoinsList(coins: vm.allCoins)
                    .transition(.move(edge: .leading))
                } else {
                    allCoinsList(coins: vm.portfolioCoins)
                    .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showSettingSheet, content: {
                SettingsView()
            })
        }
        .background(
            NavigationLink(
                destination: DetailsLoadingView(coin: $selectedCoin),
                isActive: $showDetailsView,
                label: {}
            )
        )
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
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioSheet.toggle()
                    } else {
                        showSettingSheet.toggle()
                    }
                    
                }
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
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .refreshable {
            vm.reloadData() 
        }
        .listStyle(.plain)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 10, trailing: 0))
    }
    
   private func segue(coin: CoinModel) -> Void {
       selectedCoin = coin
       showDetailsView.toggle()
    }
    
    private var columnTitle : some View {
        HStack {
            sortButton(text: "Coins", defaultSort: .rank, secondSort: .rankReversed)
            if showPortfolio {
                Group {
                    Spacer()
                    sortButton(text: "Holdings", defaultSort: .holdings, secondSort: .holdingsReversed)
                }
            }
            Spacer()
            sortButton(text: "Price", defaultSort: .price, secondSort: .priceReversed)
            
            Button(action: {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            }, label: {
                Image (systemName: "goforward")
                    .rotationEffect (Angle(degrees: vm.isLoading ? 360: 0), anchor:.center)
            })
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .padding([.leading, .top, .trailing])
    }
    
    func sortButton(text: String, defaultSort: sortOption, secondSort: sortOption) -> some View {
        HStack {
            Text(text)
            Image(systemName: "chevron.down")
                .rotationEffect(Angle(degrees: vm.sortOptions == defaultSort ? 0 : 180))
                .opacity([defaultSort, secondSort].contains(vm.sortOptions) ? 1 : 0)
        }
        .onTapGesture {
            withAnimation(.default) {
                if vm.sortOptions == defaultSort {
                    vm.sortOptions = secondSort
                } else {
                    vm.sortOptions = defaultSort
                }
            }
        }
    }
    
}
