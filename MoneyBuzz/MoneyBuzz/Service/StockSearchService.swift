//
//  StockSearchService.swift
//  MoneyBuzz
//
//  Created by Alexander Forsanker on 11/24/22.
//

import Foundation
import Combine


struct StockSearchService {
    static func getSearchResults(for searchString: String) -> AnyPublisher<StockSearchData, Error> {
        let url = URL(string: "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(searchString)&apikey=LO58U5WZML3IIJNW")!
            
        return URLSession.shared.dataTaskPublisher(for: url).tryMap { element -> Data in
            guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode < 400 else {
                throw URLError(.badServerResponse)
            }
            return element.data
        }
        .decode(type: StockSearchData.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
}
