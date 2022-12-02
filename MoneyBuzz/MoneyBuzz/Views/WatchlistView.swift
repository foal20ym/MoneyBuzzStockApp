//
//  WatchlistView.swift
//  MoneyBuzz
//
//  Created by Alexander Forsanker on 11/23/22.
//

import SwiftUI

struct WatchlistView: View {
    @ObservedObject private var stockModel = StockViewModel()
    @ObservedObject private var stockSearchModel = StockSearchViewModel()
    
    @State private var searchTicker = ""
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(Color(red: 0.3703474402, green: 0.8287841678, blue: 0.747587502))]
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(stockSearchModel.searchResults) { results in
                        HStack {
                            Text("\(results.bestMatches[0].symbol)")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .onTapGesture {
                        stockModel.stockTicker = searchTicker
                        stockModel.addStockToWatchlist()
                    }
                }
                .searchable(text: $searchTicker)
                .autocapitalization(.none)
                .onChange(of: searchTicker, perform: { searchText in
                    
                    if !searchText.isEmpty {
                        stockSearchModel.loadSearchResults(for: searchTicker)
                        
                    } else {
                        stockSearchModel.searchResults = []
                    }
                })
                .navigationTitle("Watchlist")
                
                List {
                    if !stockModel.stocks.isEmpty {
                        ForEach(stockModel.stocks) { stock in
                            NavigationLink(destination: IndividualStockView( stock: stock)) {
                                HStack {
                                    Text("\(stock.metaData.symbol)")
                                    
                                    Spacer()
                                    
                                    LineChart(values: stock.closeValues)
                                        .fill( LinearGradient(
                                            gradient: Gradient(colors: [.green.opacity(0.7), .green.opacity(0.2), .green.opacity(0)]),
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                        )
                                        .frame(width: 150, height: 50)
                                    
                                    VStack{
                                        Text("\(Float(stock.latestClose)!, specifier: "%2.f")")
                                    }
                                }
                            }
                        }
                        .onDelete(perform: stockModel.deleteStockFromWatchlist(at:))
                    } else {
                        Text("Your watchlist is empty!").font(.title).foregroundColor(Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235))
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
    }
}

struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistView()
    }
}
/*
 HStack {
     TextField("Ticker:", text: $stockModel.stockTicker)
         .textFieldStyle(RoundedBorderTextFieldStyle())
     
     Button(action: stockModel.addStockToWatchlist) {
         Label("", systemImage: "plus")
     }
     .disabled(!stockModel.isTickerValid)
     .foregroundColor(Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235))
 }
 */

