//
//  DataService.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-21.
//

import Foundation
import Combine


struct DataService {
    static func loadDataFromAPI(for stockTicker: String) -> AnyPublisher<StockData, Error> {
        let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(stockTicker)&interval=5min&apikey=LO58U5WZML3IIJNW")!
            
        return URLSession.shared.dataTaskPublisher(for: url).tryMap { element -> Data in
            guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode < 400 else {
                throw URLError(.badServerResponse)
            }
            return element.data
        }
        .decode(type: StockData.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
}
