//
//  XmarkButtonView.swift
//  CryptoApp
//
//  Created by MacBook on 11/11/2024.
//

import SwiftUI

struct XmarkButtonView: View {
    
    let action: () -> Void
    
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XmarkButtonView {}
}
