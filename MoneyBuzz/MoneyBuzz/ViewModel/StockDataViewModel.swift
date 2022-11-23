//
//  StockDataViewModel.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-22.
//

import Foundation
import Combine

final class StockViewModel: ObservableObject {
    private let context = PersistenceController.shared.container.viewContext
    
    private var cancellable = Set<AnyCancellable>()
    
    @Published var stocks: [StockData] = []
    
    @Published var ticker = ""
    @Published var stockEntities: [StockEntity] = []
    
    public init() {
        loadFromCoreData()
        
        stocks = []
        stockEntities.forEach { stockEntity in
            loadStockData(for: stockEntity.ticker ?? "")
        }
    }
    
    func loadFromCoreData() {
        do {
            stockEntities = try context.fetch(StockEntity.fetchRequest())
        } catch {
            print(error)
        }
    }
    
    func addStock() {
        let newStock = StockEntity(context: context)
        newStock.ticker = ticker
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        loadStockData(for: ticker)
        
        ticker = ""
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

