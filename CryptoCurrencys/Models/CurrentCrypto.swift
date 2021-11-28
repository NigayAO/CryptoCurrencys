//
//  CurrentCrypto.swift
//  CryptoCurrencys
//
//  Created by Alik Nigay on 28.11.2021.
//

import Foundation

struct Crypto {
    let cost: Double
    
    var getCostString: String {
        String(format: "%.2f", cost)
    }
    
    init? (for currency: Currency) {
        cost = currency.rate
    }
}
