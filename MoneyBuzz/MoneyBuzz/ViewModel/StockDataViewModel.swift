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
    private let faangStocks: [String] = [
        "META",
        "AAPL",
        "AMZN",
        "NFLX",
        "GOOG",
    ]
    private var mostOwnedStocks: [String] = [
        "TSLA",
        "AAPL",
        "MSFT",
        "NIO",
        "AMC",
    ]
    @Published var stocks: [StockData] = []
    @Published var stockTicker = ""
    @Published var isTickerValid = false
    @Published var stockEntities: [StockEntity] = []
    @Published var faangStockTickers: [StockData] = []
    @Published var mostOwnedStockTickers: [StockData] = []
    
    
    public init() {
        loadFromCoreData()
        validateTicker()
        loadStockLists()
        
        stocks = []
        stockEntities.forEach { stockEntity in
            loadStockData(for: stockEntity.ticker ?? "")
        }
        
        faangStockTickers = []
        mostOwnedStockTickers = []
        
        faangStocks.forEach { ticker in
            loadMostOwnedStocksData(for: ticker)
        }
        
        mostOwnedStocks.forEach { ticker in
            loadFAANGStocksData(for: ticker)
        }
    }

    
    func loadStockLists() {
        faangStockTickers = []
        mostOwnedStockTickers = []
        
        faangStocks.forEach { ticker in
            loadMostOwnedStocksData(for: ticker)
        }
        
        mostOwnedStocks.forEach { ticker in
            loadFAANGStocksData(for: ticker)
        }
    }
    
    public func loadMostOwnedStocksData(for ticker: String) {
        DataService.getDataFromStockAPI(for: ticker).sink { completion in
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
                self.mostOwnedStockTickers.append(stockData)
            }
        }.store(in: &cancellable)
    }
    
    public func loadFAANGStocksData(for ticker: String) {
        DataService.getDataFromStockAPI(for: ticker).sink { completion in
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
                self.faangStockTickers.append(stockData)
            }
        }.store(in: &cancellable)
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
    
    func addStockToWatchlist() {
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
    
    func deleteStockFromWatchlist(at indexSet: IndexSet) {
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
        DataService.getDataFromStockAPI(for: stockTicker.uppercased()).sink { completion in
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
                self.stocks.append(stockData)
            }
        }.store(in: &cancellable)
    }
}

