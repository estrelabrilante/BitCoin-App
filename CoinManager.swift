//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
protocol CoinManagerDelegate {
    func didUpdatePrice(price: String,currency: String);
    func didfailWithError(error: Error);
}
import Foundation

struct CoinManager {
    var delegate: CoinManagerDelegate?;
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
   // let apiKey = "YOUR_API_KEY_HERE"
    let apiKey = "872B7167-254C-46DA-AF84-3B0F8DAEB162"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency : String){
      //  let urlString = "\(baseURL)?\(apiKey)&q=\(currency)"
        let urlString = "\(baseURL)/\(currency)?apiKey=\(apiKey)";        self.performRequest(with: urlString);
    }
    //Networking
    func performRequest(with urlString : String){
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default);
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                };
                if let safeData = data{
               //swift object into a string use string initialiser
                   let dataString = String(data: data!, encoding: .utf8);
                   print(dataString!);
                    //parse JSON data into real swift object
                    self.parseJSON(currencyData: safeData)
                   }
            }
            task.resume();
                   
            }
            
    }
    func parseJSON(currencyData: Data){
        let decoder = JSONDecoder();
        do{
            let decodedData = try decoder.decode(CurrencyData.self, from: currencyData);
            print(decodedData.rate)
        }
        catch{
            print(error)
        }
    }
}
