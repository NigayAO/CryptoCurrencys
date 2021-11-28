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
    
    private var choosenCrypto = "BTC"
    private var choosenCurrency = "EUR"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network.delegate = self
    }
    
    @IBAction func changedSegmentContoll(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        choosenCurrency = network.fiats[index]
    }

    @IBAction func buttonPressed() {
        network.fetchCrypto(for: choosenCrypto, fiat: choosenCurrency)
    }
}

//MARK: - UIPickerViewDelegate
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        network.cryptos.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        network.cryptos[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choosenCrypto = network.cryptos[row]
    }
}

//MARK: - NetworkCryptoManagerDelegate
extension MainViewController: NetworkCryptoManagerDelegate {
    func updateInterFace(_: NetworkCryptoManager, _ crypto: Crypto) {
        DispatchQueue.main.async {
            self.resultLabel.text = crypto.getCostString
        }
    }
}



