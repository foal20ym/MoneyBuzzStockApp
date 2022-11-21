//
//  DataService.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-21.
//

import Foundation
import Combine


struct DataService {
    static func loadDataFromAPI(for ticker: String) -> AnyPublisher<StockData, Error> {
        guard let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(ticker)&interval=5min&apikey=LO58U5WZML3IIJNW") else {
            print("Error when initilazing url")
            return
        }
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
