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
    @ObservedObject private var loginViewModel = LoginViewViewModel()
    @State private var searchTicker = ""
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(Color(red: 0.3703474402, green: 0.8287841678, blue: 0.747587502))]
    }
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(stockSearchModel.searchResults) { results in
                        Text("\(results.bestMatches[0].symbol)")
                    }.onTapGesture {
                        stockModel.stockTicker = searchTicker
                        stockModel.addStockToWatchlist()
                    }
                }.searchable(text: $searchTicker).autocapitalization(.none).onChange(of: searchTicker, perform: { searchText in
                    if !searchText.isEmpty {
                        stockSearchModel.loadSearchResults(for: searchTicker)
                    } else {
                        stockSearchModel.searchResults = []
                    }
                }).navigationTitle("Watchlist")
                    List {
                        if !stockModel.stocks.isEmpty {
                                ForEach(stockModel.stocks) { stock in
                                    NavigationLink(destination: IndividualStockView( stock: stock)) {
                                        
                                        HStack {
                                            Text("\(stock.metaData.symbol)").foregroundColor(Color(red: 0.23921568627450981, green: 0.24705882352941178, blue: 0.3843137254901961))
                                            Spacer()
                                            LineChart(values: stock.closeValues).fill( LinearGradient(gradient: Gradient(colors: [.green.opacity(0.7),.green.opacity(0.2),.green.opacity(0)]),startPoint: .top,endPoint: .bottom)).frame(width: 150, height: 50)
                                            Text("\(Float(stock.latestClose)!, specifier: "%.2f")").foregroundColor(Color(red: 0.23921568627450981, green: 0.24705882352941178, blue: 0.3843137254901961))
                                        }
                                    }
                                }.onDelete(perform: stockModel.deleteStockFromWatchlist(at:))
                        } else {
                            Text("Your watchlist is empty!").font(.title).foregroundColor(Color(red: 0.23921568627450981, green: 0.24705882352941178, blue: 0.3843137254901961))
                        }
                    }
                    .frame(width: 400, height: 470)
                    .scrollContentBackground(.hidden)
            }
        }
        .onAppear {
            stockModel.loadFromCoreData()
        }
    }
}

struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistView()
    }
}
