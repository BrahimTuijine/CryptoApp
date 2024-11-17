//
//  LaunchView.swift
//  CryptoApp
//
//  Created by MacBook on 17/11/2024.
//

import SwiftUI

struct LaunchView: View {
    
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    
    @State private var loadingText: [String] = "Loading your portfolio...".map {String($0)}
    @State private var startAnimation: Bool = false
    @State private var counter: Int = 0
    @State private var loop: Int = 0
    
    @Binding var showLaunchView : Bool

    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            
                Image("logo-transparent")
                    .resizable()
                .frame (width: 100, height: 100)
                
                ZStack {
                    if startAnimation {
                        HStack(spacing: 0.0) {
                            ForEach(loadingText.indices, id: \.self) { index in
                                Text(loadingText[index])
                                    .font(.headline)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.launch.accent)
                                    .offset(y: counter == index ? -5 : 0)
                            }
                        }.transition(.scale.animation(.easeInOut))
                    }
                }
                .offset(y: 70)
            
        }
        .onAppear {
            startAnimation.toggle()
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring()){
                if loadingText.count == counter {
                    counter = -1
                    loop += 1
                    if loop == 2 {
                        showLaunchView = false
                    }
                }
                counter += 1
            }
        })
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}
