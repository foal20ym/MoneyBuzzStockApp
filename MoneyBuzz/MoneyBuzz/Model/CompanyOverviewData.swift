//
//  CompanyOverviewData.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-29.
//

import Foundation

struct CompanyOverviewData: Codable, Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    let description: String
    let exchange: String
    let currency: String
    
    
    private enum CodingKeys: String, CodingKey {
        case symbol = "Symbol"
        case name = "Name"
        case description = "Description"
        case exchange = "Exchange"
        case currency = "Currency"
    }
}


