//
//  ViewController.swift
//  Cryptocurrency price tracker
//
//  Created by Mohammed Zaid Khan on 22.08.19.
//  Copyright © 2019 Mohammed Zaid Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    var crpCcy:[String] = []
    var ccy:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        crpCcy = ["BTC", "ETH", "XRP", "BCH"]
        ccy = ["USD", "EUR", "JPY", "CHF"]
        self.picker.delegate = self
        self.picker.dataSource = self        
        getPrice(crpCcy: crpCcy[picker.selectedRow(inComponent: 0)],ccy: ccy[picker.selectedRow(inComponent: 1)])
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return crpCcy.count;
        }
        else {
            return ccy.count;
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0)
        {
            return crpCcy[row];
        }
        else {
            return ccy[row];
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getPrice(crpCcy: crpCcy[picker.selectedRow(inComponent: 0)],ccy: ccy[picker.selectedRow(inComponent: 1)])
    }
    
    @IBAction func refreshData(_ sender: Any) {
        getPrice(crpCcy: crpCcy[picker.selectedRow(inComponent: 0)],ccy: ccy[picker.selectedRow(inComponent: 1)])
    }
    
    func getPrice(crpCcy: String, ccy: String){
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=" + crpCcy + "&tsyms=" + ccy) { URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options:[]) as? [String:Double]{
                    if let price = jsonDictionary[ccy] {
                        DispatchQueue.main.async {
                            let formatter = NumberFormatter()
                            formatter.currencyCode = ccy
                            formatter.numberStyle = .currency
                            let formattedPrice = formatter.string(from: NSNumber(value:price))
                            self.price.text = formattedPrice
                        }
                    }
                }
            }
            else {
                print("wrong =(")
            }
            }.resume()
        }
    }
}
