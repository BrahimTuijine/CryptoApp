//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by MacBook on 10/11/2024.
//

import SwiftUI

struct SearchBarView: View {
    
    @EnvironmentObject private var vm : HomeViewModel
    
    var body: some View {
        
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(vm.searchText.isEmpty ? .theme.secondaryText : .theme.accent)
            
            TextField("Search by name or symbol...", text: $vm.searchText)
                .autocorrectionDisabled(true)
                .foregroundColor(
                     .theme.accent)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(.theme.accent)
                        .opacity(vm.searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            vm.searchText = ""
                        }
                    , alignment: .trailing
                )
            
            
                
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color:
                        Color.theme.accent.opacity(0.15),
                    radius: 10, x: 0, y:0)
        )
        .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {

        SearchBarView()
            .environmentObject(DeveloperPreview.instance.homeVm)
            .preferredColorScheme(.light) 
}

#Preview(traits: .sizeThatFitsLayout) {

        SearchBarView()
            .environmentObject(DeveloperPreview.instance.homeVm)
            .preferredColorScheme(.dark)
}
