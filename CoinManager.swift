//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
   // let apiKey = "YOUR_API_KEY_HERE"
    let apiKey = "872B7167-254C-46DA-AF84-3B0F8DAEB162"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency : String){
      //  let urlString = "\(baseURL)?\(apiKey)&q=\(currency)"
        let urlString = "\(baseURL)/\(currency)?apiKey=\(apiKey)";        self.performRequest(with: urlString);
    }
    func performRequest(with urlString : String){
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default);
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                }
               //swift object into a string use string initialiser
                   let dataString = String(data: data!, encoding: .utf8);
                   print(dataString);
                   }
               
            task.resume();
                   
            }
            
    }
}
