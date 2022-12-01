//
//  CompanyOverviewViewModel.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-29.
//

import Foundation
import Combine

final class CompanyOverviewViewModel: ObservableObject {
    
    @Published var ticker: String = ""
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var exchange: String = ""
    @Published var currency: String = ""
    private var cancellable = Set<AnyCancellable>()
    
    
   public func normalizeDataPointsForGraph(for datapoints: [CGFloat]) -> [CGFloat] {
        if let min = datapoints.min(), let max = datapoints.max() {
            return datapoints.map { ($0-min) / (max-min)}
        }
        return []
    }
    
   public func loadCompanyData(for stockTicker: String) {
        CompanyOverviewDataService.getCompanyOverviewData(for: stockTicker.uppercased()).sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
                return
            case .finished:
                return
            }
        } receiveValue: { CompanyData in
            DispatchQueue.main.async {
                self.ticker = CompanyData.symbol
                self.name = CompanyData.name
                self.description = CompanyData.description
                self.exchange = CompanyData.exchange
                self.currency = CompanyData.currency
            }
        }.store(in: &cancellable)
    }
}

