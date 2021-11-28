//
//  CurrencyModel.swift
//  CryptoCurrencys
//
//  Created by Alik Nigay on 27.11.2021.
//
import Foundation

struct Currency: Decodable {
    let assetIdBase: String
    let assetIdQuote: String
    let rate: Double
    
    enum CodingKeys: String, CodingKey, Decodable {
        case assetIdBase = "asset_id_base"
        case assetIdQuote = "asset_id_quote"
        case rate
    }
}
