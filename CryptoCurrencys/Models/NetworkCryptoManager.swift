//
//  NetworkManager.swift
//  CryptoCurrencys
//
//  Created by Alik Nigay on 27.11.2021.
//

import Foundation

protocol NetworkCryptoManagerDelegate {
    func updateInterFace(_: NetworkCryptoManager, _ crypto: Crypto)
}

struct NetworkCryptoManager {
    
    var delegate: NetworkCryptoManagerDelegate?
        
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "CF34A751-B798-4DD5-AB8A-F05C8D1F2C74"
    let cryptos = ["BTC", "ETH", "DOGE"]
    let fiats = ["EUR", "RUB", "USD"]
    
    func fetchCrypto(for crypto: String, fiat: String) {
        let urlString = "\(baseURL)/\(crypto)/\(fiat)?apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let crypto = parseJSON(for: data) {
                    self.delegate?.updateInterFace(self, crypto)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(for data: Data) -> Crypto? {
        let decode = JSONDecoder()
        do {
            let currentCryptoData = try decode.decode(Currency.self, from: data)
            guard let currentCrypto = Crypto(for: currentCryptoData) else { return nil}
            return currentCrypto
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
}
