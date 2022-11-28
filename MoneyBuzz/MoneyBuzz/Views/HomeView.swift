//
//  HomeView.swift
//  MoneyBuzz
//
//  Created by Alexander Forsanker on 11/22/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var model = StockViewModel()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("\(Image(systemName: "globe")) Popular Stocks").font(.title).bold().foregroundColor(Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235))
                    ForEach(model.popularStockTickers) { stock in
                        HStack {
                            Text(stock.metaData.symbol)
                            
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 150)
                            
                            VStack{
                                Text(stock.latestClose)
                                Text("Change")
                            }
                        }
                        .background(Color(red: 0.9215686274509803, green: 0.9215686274509803, blue: 0.9215686274509803))
                    }
                }

                Section{
                    Text("\(Image(systemName: "eurosign")) Currencies").font(.title).bold().foregroundColor(Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235))
                    
                    ForEach(model.forexPairs) { pair in
                        HStack {
                            Text("\(pair.currencyData.currencyFromCode)\(pair.currencyData.currencyToCode)")
                            
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 150)
                            
                            VStack{
                                Text("Ask: \(pair.currencyData.askPrice)")
                                Text("Bid: \(pair.currencyData.bidPrice)")
                            }
                        }
                        .background(Color(red: 0.9215686274509803, green: 0.9215686274509803, blue: 0.9215686274509803))
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(GroupedListStyle())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
