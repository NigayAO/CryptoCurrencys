//
//  ViewController.swift
//  CryptoCurrencys
//
//  Created by Alik Nigay on 27.11.2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    private var network = NetworkCryptoManager()
    private let dataManager = DataManager.shared
    
    private var choosenCrypto = "BTC"
    private var choosenCurrency = "EUR"
    
    @IBAction func changedSegmentContoll(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        choosenCurrency = sender.titleForSegment(at: index)!
    }

    @IBAction func buttonPressed() {
        network.fetchCrypto(for: choosenCrypto, fiat: choosenCurrency) { crypto in
            DispatchQueue.main.async {
                self.resultLabel.text = crypto.getCostString
            }
        }
    }
}

//MARK: - UIPickerViewDelegate
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataManager.cryptos.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        dataManager.cryptos[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choosenCrypto = dataManager.cryptos[row]
    }
}
