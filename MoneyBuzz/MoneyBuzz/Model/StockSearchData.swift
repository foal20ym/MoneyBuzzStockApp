//
//  StockSearchData.swift
//  MoneyBuzz
//
//  Created by Alexander Forsanker on 11/24/22.
//

import Foundation

struct StockSearchData: Codable, Identifiable {
    let id = UUID()
    struct Data: Codable {
        let symbol: String
        let name: String
        let type: String
        let region: String
        let marketOpen: String
        let marketClose: String
        let timezone: String
        let currency: String
        var matchScore: String
        
        private enum CodingKeys: String, CodingKey {
            case symbol = "1. symbol"
            case name = "2. name"
            case type = "3. type"
            case region = "4. region"
            case marketOpen = "5. marketOpen"
            case marketClose = "6. marketClose"
            case timezone = "7. timezone"
            case currency = "8. currency"
            case matchScore = "9. matchScore"
        }
    }
    
    let bestMatches: [Data]

    private enum CodingKeys: String, CodingKey {
        case bestMatches = "bestMatches"
    }
}
