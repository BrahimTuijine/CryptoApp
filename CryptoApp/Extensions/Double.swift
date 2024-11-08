//
//  Double.swift
//  CryptoApp
//
//  Created by MacBook on 08/11/2024.
//

import Foundation


extension Double {
    /// Converts a Double into Currency with 2-maximumFractionDigits decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    /// ```
    private func currencyFormatter(maximumFractionDigits: Int) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = maximumFractionDigits
        return formatter
    }
    
    
    /// Converts a Double into a Currency as a String with 2-maximumFractionDigits decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.123456 to "$0.123456"
    /// ```
    func asCurrency(maximumFractionDigits: Int) -> String {
        return currencyFormatter(maximumFractionDigits: maximumFractionDigits).string(from: NSNumber(value: self)) ?? "$0.00"
    }
    
    /// Converts a Double into a String representation
    /// ```
    /// Convert 1.23456 to "1,23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts a Double into a String representation with percent symbol
    /// ```
    /// Convert 1.23456 to "1,23%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
     
}
