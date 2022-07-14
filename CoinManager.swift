//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String);
    func didfailWithError(error: Error);
};

struct CoinManager {
    var delegate: CoinManagerDelegate?;
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
   // let apiKey = "YOUR_API_KEY_HERE"
    let apiKey = "872B7167-254C-46DA-AF84-3B0F8DAEB162"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"];
    
    func getCoinPrice(for currency : String){
      //  let urlString = "\(baseURL)?\(apiKey)&q=\(currency)"
        let urlString = "\(baseURL)/\(currency)?apiKey=\(apiKey)";
        print(urlString);
    //Networking
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default);
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didfailWithError(error: error!)
                    print(error!)
                    return
                };
                if let safeData = data{
               //swift object into a string use string initialiser
                   let dataString = String(data: data!, encoding: .utf8);
                   print(dataString!);
            //parse JSON data into real swift object
                    if let currencyObject = self.parseJSON(currencyData: safeData){
                        let priceString = String(format: "%.2f", currencyObject);
            self.delegate?.didUpdatePrice(price: priceString,currency: currency);
                        print("Currency")
                        print(currency);
                        print("Price for 1 currency selected:")
                        print(priceString);
                        }
                   }
            }
        task.resume();
        }
        
    }
    func parseJSON(currencyData: Data) -> Double?{
        let decoder = JSONDecoder();
        do{
            let decodedData = try decoder.decode(CurrencyData.self, from: currencyData);
            let lastPrice = decodedData.rate;
            print(decodedData.rate);
            return lastPrice
            
        }
        catch{
            delegate?.didfailWithError(error: error)
            return nil
            print(error)
        }
    }
}
