//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by MacBook on 07/11/2024.
//

import SwiftUI

@main
struct CryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(.theme.accent)]
        UINavigationBar.appearance().tintColor = UIColor(.theme.accent)
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    @State var showLaunchView: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .toolbar(.hidden)
                }
                .navigationViewStyle(.stack)
                .environmentObject(vm)
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
