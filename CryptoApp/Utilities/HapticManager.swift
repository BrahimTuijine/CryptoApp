//
//  HabticManager.swift
//  CryptoApp
//
//  Created by MacBook on 13/11/2024.
//

import Foundation
import SwiftUI

class HapticsManager {
    static let instance = HapticsManager()
    
    private init(){}
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) -> Void {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) -> Void {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
