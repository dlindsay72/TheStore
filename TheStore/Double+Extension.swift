//
//  Double+Extension.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-17.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import Foundation

extension Double {
    var currencyFormatter: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
