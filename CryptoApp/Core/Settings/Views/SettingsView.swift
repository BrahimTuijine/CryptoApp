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
    let websiteURL = URL(string:"https://forgecli.dev/#team")!
    let coingeckoURL = URL(string:"https://www.coingecko.com")!
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                
                List {
                    appInfoSection.listRowBackground(Color.theme.background.opacity(0.5))
                    coinGeckoSection.listRowBackground(Color.theme.background.opacity(0.5))
                    developerSection.listRowBackground(Color.theme.background.opacity(0.5))
                    applicationSection.listRowBackground(Color.theme.background.opacity(0.5))
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
    
    private var coinGeckoSection: some View {
            Section {
                VStack(alignment: .leading) {
                    Image("coingecko")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    Text("The cryptocurrency data that is used in this app come form a free api from CoinGecko! Prices may be slightly delayed.")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundColor(.theme.accent)
                }
                .padding(.vertical)
                
                Link("Visit CoinGecko 🥳", destination: coingeckoURL)
                
            } header: {
                Text("CoinGecko")
            }
        
    }
    
    private var developerSection: some View {
            Section {
                VStack(alignment: .leading) {
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    Text ("This app was developed by Brahim tuijine. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistance.")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundColor(.theme.accent)
                }
                .padding(.vertical)
                
                Link("Visit Website 🥳", destination: websiteURL)
                
            } header: {
                Text("Developer")
            }
    }
    
    private var applicationSection: some View {
            Section {
                Link("Terms of Service", destination: defaultURL)
                Link("Privacy Policy", destination: defaultURL)
                Link("Company Website", destination: defaultURL)
                Link("Learn More", destination: defaultURL)
                
            } header: {
                Text("Application")
            }
    }
}
