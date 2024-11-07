//
//  CircleBtnAnimationView.swift
//  CryptoApp
//
//  Created by MacBook on 07/11/2024.
//

import SwiftUI

struct CircleBtnAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.3 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 1) : .none, value: animate)
//            .onAppear {
//                animate = true
//            }
    }
}

#Preview {
    CircleBtnAnimationView(animate: .constant(false))
}
