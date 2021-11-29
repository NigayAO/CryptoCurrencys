//
//  DataManager.swift
//  CryptoCurrencys
//
//  Created by Alik Nigay on 29.11.2021.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    let cryptos = ["BTC", "ETH", "DOGE"]
    let fiats = ["EUR", "RUB", "USD"]
    
    private init() {}
}
