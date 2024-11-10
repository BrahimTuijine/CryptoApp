//
//  UiApplication.swift
//  CryptoApp
//
//  Created by MacBook on 10/11/2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() -> Void {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
