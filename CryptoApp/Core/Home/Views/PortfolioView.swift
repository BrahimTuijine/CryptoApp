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
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("hello brahim")
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
