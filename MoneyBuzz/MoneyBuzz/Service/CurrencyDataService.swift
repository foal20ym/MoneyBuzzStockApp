//
//  CurrencyDataService.swift
//  MoneyBuzz
//
//  Created by Alexander Forsanker on 11/28/22.
//

import Foundation
import Combine

struct CurrencyDataService {
    static func getForexPairResults(for currencyFrom: String, for currencyTo: String) -> AnyPublisher<CurrencyData, Error> {
        let url = URL(string: "https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=\(currencyFrom)&to_currency=\(currencyTo)&apikey=LO58U5WZML3IIJNW")!
            
        return URLSession.shared.dataTaskPublisher(for: url).tryMap { element -> Data in
            guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode < 400 else {
                throw URLError(.badServerResponse)
            }
            return element.data
        }
        .decode(type: CurrencyData.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
}
