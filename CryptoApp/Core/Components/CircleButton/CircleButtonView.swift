//
//  CircleButtonView.swift
//  CryptoApp
//
//  Created by MacBook on 07/11/2024.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(.theme.background)
            )
            .shadow(color: .theme.accent.opacity(0.25),
                    radius: 10,
                    x: 0.0,
                    y: 0.0
            )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CircleButtonView(iconName: "info")
            .preferredColorScheme(.light)
}

#Preview(traits: .sizeThatFitsLayout) {
        CircleButtonView(iconName: "plus")
            .preferredColorScheme(.dark )
}
