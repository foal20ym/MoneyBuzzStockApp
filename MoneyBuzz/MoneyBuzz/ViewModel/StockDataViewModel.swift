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
    @Published var stockTicker = ""
    @Published var isTickerValid = false
    @Published var stockEntities: [StockEntity] = []
    
    public init() {
        loadFromCoreData()
        validateTicker()
        
        stocks = []
        stockEntities.forEach { stockEntity in
            loadStockData(for: stockEntity.ticker ?? "")
        }
        validateTicker()
    }
    
    func loadFromCoreData() {
        do {
            stockEntities = try context.fetch(StockEntity.fetchRequest())
        } catch {
            print(error)
        }
    }
    
    func validateTicker() {
        $stockTicker
            .sink { [unowned self] newValue in
                self.isTickerValid = !newValue.isEmpty
            }
            .store(in: &cancellable)
    }
    
    func addStock() {
        let newStock = StockEntity(context: context)
        newStock.ticker = stockTicker
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        stockEntities.append(newStock)
        loadStockData(for: stockTicker)
        
        stockTicker = ""
    }
    
    func deletaFromStocks(at indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
            
        }
        
        stocks.remove(at: index)
        let stockToRemove = stockEntities.remove(at: index)
        
        context.delete(stockToRemove)
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    public func loadStockData(for stockTicker: String) {
        DataService.loadDataFromAPI(for: stockTicker.uppercased()).sink { completion in
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

