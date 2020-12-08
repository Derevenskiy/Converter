//
//  ViewController.swift
//  Currency Converter
//
//  Created by Артем Чернышов on 07.12.2020.
//  Copyright © 2020 Artem Chernyshov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currencyArray = ["RUB","USD", "EUR"]

    var value = "1"
    var currencyFrom = ""
    var currencyTo = ""

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var rectangleView: UIView!
    @IBOutlet weak var сurrencyOnePicker: UIPickerView!
    @IBOutlet weak var valueTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.rectangleView.layer.cornerRadius = 20
        сurrencyOnePicker.dataSource = self
        сurrencyOnePicker.delegate = self

        valueTextField.addTarget(self, action: #selector(changeValueTextField(param:)), for: .editingChanged)
    }

    func conversion() {
        guard let url = URL(string: "https://api.1forge.com/convert?from=\(currencyFrom)&to=\(currencyTo)&quantity=\(value)&api_key=9B6ZkQIwcsPiCPVi0QMIS2GM88H17VBN") else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in

                guard let data = data else { return }
                guard error == nil else {return}

                do {
                    let decode = try JSONDecoder().decode(ModelDecodable.self, from: data)
                        DispatchQueue.main.async {
                            self.textLabel.text = decode.text
                            print(decode)
                        }
                } catch let error {
                    print(error)
                }
            }.resume()
    }
    // MARK: - FunctionAddTagetTextField
    @objc func changeValueTextField(param: UITextField) {
        if let textField = valueTextField.text {
            value = textField
            conversion()
        }
    }
}

// MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
}
// MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            currencyFrom = currencyArray[row]
            conversion()
        } else if component == 1 {
            currencyTo = currencyArray[row]
            conversion()
            }
        }
}
