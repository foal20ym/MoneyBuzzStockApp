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
            Form {
                Section {
                    Text("\(Image(systemName: "apple.logo")) FAANG Stocks").font(.title).bold().foregroundColor(Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235))
                    List {
                        ForEach(model.faangStockTickers) { stock in
                            HStack {
                                Text(stock.metaData.symbol)
                                Spacer()
                                LineChart(values: stock.closeValues).fill( LinearGradient(gradient: Gradient(colors: [.green.opacity(0.7), .green.opacity(0.2), .green.opacity(0)]),startPoint: .top,endPoint: .bottom)).frame(width: 150, height: 50)
                                Text("\(Float(stock.latestClose)!, specifier: "%.2f")")
                            }
                        }
                    }
                }
                Section {
                    Text("\(Image(systemName: "globe")) Most Owned Stocks").font(.title).bold().foregroundColor(Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235))
                    List {
                        ForEach(model.mostOwnedStockTickers) { stock in
                            HStack {
                                Text(stock.metaData.symbol)
                                Spacer()
                                LineChart(values: stock.closeValues).fill( LinearGradient(gradient: Gradient(colors: [.green.opacity(0.7), .green.opacity(0.2), .green.opacity(0)]),startPoint: .top,endPoint: .bottom)).frame(width: 150, height: 50)
                                Text("\(Float(stock.latestClose)!, specifier: "%.2f")")
                            }
                        }
                    }
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
