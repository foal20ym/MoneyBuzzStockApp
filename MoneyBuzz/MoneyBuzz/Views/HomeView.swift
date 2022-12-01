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
                Text("\(Image(systemName: "apple.logo")) FAANG Stocks").font(.title).bold().foregroundColor(Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235))
                ForEach(model.faangStockTickers) { stock in
                    HStack {
                        Text(stock.metaData.symbol)
                        
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
                            Text("\(Float(stock.latestClose)!, specifier: "%.2f")")
                            Text("Change")
                        }
                    }
                    .background(Color(red: 0.9215686274509803, green: 0.9215686274509803, blue: 0.9215686274509803))
                }
            }
            List {
                Text("\(Image(systemName: "globe")) Most Owned Stocks").font(.title).bold().foregroundColor(Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235))
                ForEach(model.mostOwnedStockTickers) { stock in
                    HStack {
                        Text(stock.metaData.symbol)
                        
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
                            Text("\(Float(stock.latestClose)!, specifier: "%.2f")")
                            Text("Change")
                        }
                    }
                    .background(Color(red: 0.9215686274509803, green: 0.9215686274509803, blue: 0.9215686274509803))
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
/*
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
 */
