//
//  WatchlistView.swift
//  MoneyBuzz
//
//  Created by Alexander Forsanker on 11/23/22.
//

import SwiftUI

struct WatchlistView: View {
    @ObservedObject private var stockModel = StockViewModel()
    @State var searchTicker: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    TextField("Ticker:", text: $stockModel.ticker)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Add", action: stockModel.addStock)
                        .disabled(!stockModel.validTicker)
                }
                if !stockModel.stocks.isEmpty {
                    ForEach(stockModel.stocks) { stock in
                        HStack {
                            Text("\(stock.metaData.symbol)")
                            
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 150)
                            
                            VStack{
                                Text("\(stock.latestClose) ")
                                Text("Change")
                            }
                        }
                        .background(Color(red: 0.9215686274509803, green: 0.9215686274509803, blue: 0.9215686274509803))
                    }
                    .onDelete(perform: stockModel.delete(at:))
                } else {
                    Text("Your watchlist is empty!").font(.title)
                }
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Watchlist")
    }
}

struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistView()
    }
}

