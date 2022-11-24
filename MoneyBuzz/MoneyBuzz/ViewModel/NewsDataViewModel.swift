//
//  NewsDataViewModel.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-24.
//

import Foundation
import Combine



final class NewsDataViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()
    @Published var news: [NewsData] = []
    
    public init() {
        news = []
        loadNewsData()
    }
    
    
    public func loadNewsData() {
        NewsDataService.getNewsDataFromAPI().sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
                return
            case .finished:
                return
            }
        } receiveValue: { newsData in
            DispatchQueue.main.async {
                print(newsData)
                self.news.append(newsData)
            }
        }.store(in: &cancellable)
    }
}
