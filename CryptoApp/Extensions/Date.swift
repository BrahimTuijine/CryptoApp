//
//  Date.swift
//  CryptoApp
//
//  Created by MacBook on 14/11/2024.
//

import SwiftUI

extension Date {
    
    // "2021-03-13T20:49:26.606Z"
    init(coinGeckoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
        
    func asShortDateFormatter() -> String {
        return shortFormatter.string(from: self)
    }
}
