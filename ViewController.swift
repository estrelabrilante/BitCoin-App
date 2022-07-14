//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIPickerViewDataSource, UIPickerViewDelegate {
    

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coinManager.delegate = self;
        //set viewcontroller as datasource to the currencyPicker object
        currencyPicker.dataSource = self
        //set viewcontroller class as delegate of currency picker
        currencyPicker.delegate = self
    }
    //MARK: UIPICKERVIEWDATASOURCE
    //how many column want in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    var coinManager = CoinManager();
    //how many rows picker should using
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return coinManager.currencyArray.count;
    }
    //title for each row in pickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return coinManager.currencyArray[row];
    }
    //select each row number and currency value from picker view and print in console
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedRow = coinManager.currencyArray[row]
        //pass selected currencyValue to coinManager
        coinManager.getCoinPrice(for: selectedRow);
        print(row);
        print(coinManager.currencyArray[row])
        
    }
}
    //MARK: coinManagerDelegate method
extension ViewController: CoinManagerDelegate{
    func didfailWithError(error: Error) {
        print(error)
    }
    
    func didUpdatePrice(price: String, currency: String){
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price;
            self.currencyLabel.text = currency
            
            
        }
        
    }

}

