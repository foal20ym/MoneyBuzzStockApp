//
//  CompanyOverviewDataService.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-29.
//

import Foundation
import Combine


struct CompanyOverviewDataService {
    static func getCompanyOverviewData(for stockTicker: String) -> AnyPublisher<CompanyOverviewData, Error> {
        let url = URL(string: "https://www.alphavantage.co/query?function=OVERVIEW&symbol=\(stockTicker)&apikey=O4D2DY1BZ05C62IX")!
        return URLSession.shared.dataTaskPublisher(for: url).tryMap { element -> Data in
            guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode < 400 else {
                throw URLError(.badServerResponse)
            }
            return element.data
        }
        .decode(type: CompanyOverviewData.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
    
}

