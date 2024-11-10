//
//  StatisticModel.swift
//  CryptoApp
//
//  Created by MacBook on 10/11/2024.
//

import Foundation


struct StatisticModel {
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
 