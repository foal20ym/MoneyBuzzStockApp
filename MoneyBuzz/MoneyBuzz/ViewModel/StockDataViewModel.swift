//
//  StockDataViewModel.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-22.
//

import Foundation
import Combine
import CoreData

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
    @Published var loginVm = LoginViewViewModel()
    
    
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
        guard loginVm.isLoggedIn == true else {
            return
        }
        let fetchRequest = NSFetchRequest<StockEntity>(entityName: "StockEntity")
        fetchRequest.predicate = NSPredicate(format: "userID == %@", LoginViewViewModel.userID)
        print("From stockDataViewModel \(LoginViewViewModel.userID)")
        do {
            stockEntities = try context.fetch(fetchRequest)
            stocks = []
            stockEntities.forEach { stockEntity in
                loadStockData(for: stockEntity.ticker ?? "")
            }
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
    
    func validateTickerUnitTest(ticker: String) -> Bool {
        guard ticker.count <= 4 else { return false }
        guard !ticker.isEmpty else { return false }
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        guard !texttest1.evaluate(with: ticker) else { return false }
        
        return true
    }
    
    func addStockToWatchlist() {
        let newStock = StockEntity(context: context)
        newStock.ticker = stockTicker
        newStock.userID = LoginViewViewModel.userID
        newStock.user = UserEntity(context: context)
        newStock.user?.userID = LoginViewViewModel.userID
        
        do {
            try context.save()
        } catch {
            print("Error when adding to watchlist \(error)")
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
        stockToRemove.user = UserEntity(context: context)
        stockToRemove.user?.userID = LoginViewViewModel.userID
        
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

