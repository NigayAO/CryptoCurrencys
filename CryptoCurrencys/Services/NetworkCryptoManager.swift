//
//  NetworkManager.swift
//  CryptoCurrencys
//
//  Created by Alik Nigay on 27.11.2021.
//

import Foundation

struct NetworkCryptoManager {
        
    private let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    private let apiKey = "CF34A751-B798-4DD5-AB8A-F05C8D1F2C74"
    
    func fetchCrypto(for crypto: String, fiat: String, completionHandler: @escaping (Crypto) -> Void) {
        let urlString = "\(baseURL)/\(crypto)/\(fiat)?apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let currentData = try JSONDecoder().decode(Currency.self, from: data)
                guard let crypto = Crypto(for: currentData) else { return }
                completionHandler(crypto)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
