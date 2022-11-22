//
//  StockDataViewModel.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-22.
//

import Foundation
import Combine

final class StockViewModel: ObservableObject {
    @Published var stocks: [StockData] = []
    private var cancellable = Set<AnyCancellable>()
    
    public init() {
        loadStockData(for: "TSLA")
    }
    
    public func loadStockData(for ticker: String) {
        DataService.loadDataFromAPI(for: ticker).sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
                //handle this later on
            case .finished:
                return
            }
        } receiveValue: { stockData in
            DispatchQueue.main.async {
                self.stocks.append(stockData)
            }
        }.store(in: &cancellable)
    }
}
