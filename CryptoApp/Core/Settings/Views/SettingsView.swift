//
//  SettingsView.swift
//  CryptoApp
//
//  Created by MacBook on 15/11/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let defaultURL = URL (string:"https://www-google.com")!
    let youtubeURL = URL(string:"https://www.youtube.com/@forge_cli")!
    let websiteURL = URL(string:"https://forgecli.dev")!
    let coingeckoURL = URL(string:"https://www.coingecko.com")!
    
    var body: some View {
        NavigationView {
            List {
                appInfoSection
                
            }
            .tint(.blue)
            .listStyle(.grouped)
            .navigationTitle("Settings")
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
    SettingsView()
}

extension SettingsView {
    private var appInfoSection: some View {
            Section {
                VStack(alignment: .leading) {
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    Text("This app was made by Brahim tuijine. It uses MVVM Architecture, Combine, Core Data!")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundColor(.theme.accent)
                }
                .padding(.vertical)
                
                Link("Sibscribe to ForgeCli 🥳", destination: youtubeURL)
                
            } header: {
                Text("Crypto App info")
            }
        
    }
    
    
}
