//
//  StockSearchViewModel.swift
//  MoneyBuzz
//
//  Created by Alexander Forsanker on 11/24/22.
//

import Foundation
import Combine

final class StockSearchViewModel: ObservableObject {
    
    private var cancellable = Set<AnyCancellable>()
    @Published var searchResults = [StockSearchData]()
    @Published var searchString = ""
    public init() {
        searchResults = []
    }
    
    func clearResults() {
        searchResults = []
        searchString = ""
    }
    
    public func loadSearchResults(for searchString: String) {
        StockSearchService.getSearchResults(for: searchString.uppercased()).sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
                return
                //handle this later on
            case .finished:
                return
            }
        } receiveValue: { stockData in
            DispatchQueue.main.async {
                self.searchResults.append(stockData)
            }
        }.store(in: &cancellable)
    }
}
