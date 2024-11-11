//
//  HomeStatView.swift
//  CryptoApp
//
//  Created by MacBook on 10/11/2024.
//

import SwiftUI

struct HomeStatView: View {
    
    @EnvironmentObject private var vm : HomeViewModel
    
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack(spacing: 0.0) {
            ForEach(vm.statistics) { stat in
                StatisticView(statistic: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatView(showPortfolio: .constant(true))
        .environmentObject(DeveloperPreview.instance.homeVm)
}
