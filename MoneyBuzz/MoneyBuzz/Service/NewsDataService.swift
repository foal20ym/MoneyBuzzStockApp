//
//  NewsDataService.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-24.
//

import Foundation
import Combine

let APIKEY = "MSR9qoqe2JhOMFWnspspaZrpVcL8CjNOD8ObkaLp"

struct NewsDataService {
    static func getNewsDataFromAPI() -> AnyPublisher<NewsData, Error> {
        let url = URL(string: "https://api.marketaux.com/v1/news/all?exchanges=NYSE%2CNASDAQ&api_token=\(APIKEY)")!
        
        return URLSession.shared.dataTaskPublisher(for: url).tryMap { element -> Data in
            guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode < 400 else {
                throw URLError(.badServerResponse)
            }
            return element.data
        }
        .decode(type: NewsData.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
        
    }
}
