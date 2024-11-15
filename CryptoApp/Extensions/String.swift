//
//  String.swift
//  CryptoApp
//
//  Created by MacBook on 15/11/2024.
//

import Foundation

extension String {
    
    var removeHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
