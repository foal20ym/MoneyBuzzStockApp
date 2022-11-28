//
//  CurrencyData.swift
//  MoneyBuzz
//
//  Created by Alexander Forsanker on 11/28/22.
//

import Foundation

struct CurrencyData: Codable, Identifiable {
    let id = UUID()
    struct Data: Codable {
        let currencyFromCode: String
        let currencyFromName: String
        let currencyToCode: String
        let currencyToName: String
        let exchangeRate: String
        let lastRefreshed: String
        let timezone: String
        let bidPrice: String
        var askPrice: String
        
        private enum CodingKeys: String, CodingKey {
            case currencyFromCode = "1. From_Currency Code"
            case currencyFromName = "2. From_Currency Name"
            case currencyToCode = "3. To_Currency Code"
            case currencyToName = "4. To_Currency Name"
            case exchangeRate = "5. Exchange Rate"
            case lastRefreshed = "6. Last Refreshed"
            case timezone = "7. Time Zone"
            case bidPrice = "8. Bid Price"
            case askPrice = "9. Ask Price"
        }
    }
    
    let currencyData: Data

    private enum CodingKeys: String, CodingKey {
        case currencyData = "Realtime Currency Exchange Rate"
    }
}
