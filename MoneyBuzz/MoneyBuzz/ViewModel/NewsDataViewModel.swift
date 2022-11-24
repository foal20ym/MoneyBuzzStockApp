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
    @Published var news: [NewsObject] = []
    
    struct NewsObject: Hashable, Identifiable {
        let id = UUID()
        let title: String
        let description: String
        let source: String
        let publishedAt: String

    }
    
    public init() {
        self.news = []
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
        } receiveValue: { [weak self ] newsData in
            DispatchQueue.main.async {
                print(newsData.title)
                self?.news.append(NewsObject(title: newsData.title, description: newsData.description, source: newsData.source, publishedAt: newsData.published_at))
            }
        }.store(in: &cancellable)
    }
}
