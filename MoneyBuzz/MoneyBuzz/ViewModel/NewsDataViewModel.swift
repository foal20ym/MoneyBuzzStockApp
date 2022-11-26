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
        dateConverter(rawDate: "2022-11-25T22:59:52.000000Z")
    }
    
    public func dateConverter(rawDate: String) -> String {
        let oldDateFormatter = DateFormatter()
        oldDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.ssssssZ"
        guard let oldDate = oldDateFormatter.date(from: rawDate) else {
            return ""
            
        }
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "yyy-MM-dd"
        
        return convertDateFormatter.string(from: oldDate)
       
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
                print(newsData)
                self?.news.append(newsData)
            }
        }.store(in: &cancellable)
    }
}
