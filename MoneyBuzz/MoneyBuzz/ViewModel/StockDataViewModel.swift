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
    private let popularStocks: [String] = [
        "META",
        "MSFT",
        "GOOG",
        "AMZN",
        "AAPL",
    ]
    private let popularForexPairs: [String:String] = [
        "EUR":"USD",
        "USD":"JPY",
        "AUD":"USD",
        "GBP":"USD",
    ]
    @Published var stocks: [StockData] = []
    @Published var stockTicker = ""
    @Published var isTickerValid = false
    @Published var stockEntities: [StockEntity] = []
    @Published var popularStockTickers: [StockData] = []
    @Published var forexPairs: [CurrencyData] = []
    
    
    public init() {
        loadFromCoreData()
        validateTicker()
        loadPopularStocks()
        loadForexPairs()
        
        stocks = []
        stockEntities.forEach { stockEntity in
            loadStockData(for: stockEntity.ticker ?? "")
        }
        validateTicker()
    }
    
    func loadForexPairs() {
        forexPairs = []
        popularForexPairs.forEach { pair in
            loadPopularPairsData(for: pair.key, for: pair.value)
        }
    }
    
    public func loadPopularPairsData(for currencyFrom: String, for currencyTo: String) {
        CurrencyDataService.getForexPairResults(for: currencyFrom, for: currencyTo).sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
                return
                //handle this later on
            case .finished:
                return
            }
        } receiveValue: { forexData in
            DispatchQueue.main.async {
                self.forexPairs.append(forexData)
            }
        }.store(in: &cancellable)
    }
    
    func loadPopularStocks() {
        popularStocks.forEach { ticker in
            loadPopularStocksData(for: ticker)
        }
    }
    
    public func loadPopularStocksData(for stockTicker: String) {
        DataService.getDataFromStockAPI(for: stockTicker).sink { completion in
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
                self.popularStockTickers.append(stockData)
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

