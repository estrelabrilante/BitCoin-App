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
        //set viewcontroller as datasource to the currencyPicker object
        currencyPicker.dataSource = self
        //set viewcontroller class as delegate of currency picker
        currencyPicker.delegate = self
    }
    //how many column want in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    let coinManager = CoinManager();
    //how many rows picker should using
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return coinManager.currencyArray.count;
    }
    //title for each row in pickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row];
    }
    //select each row number and currency value from picker view and print in cosole
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row);
        print(coinManager.currencyArray[row])
        
    }

}

