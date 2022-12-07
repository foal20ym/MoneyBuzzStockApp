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
                                    .foregroundColor(Color(red: 0.23921568627450981, green: 0.24705882352941178, blue: 0.3843137254901961))
                                Spacer()
                                LineChart(values: stock.closeValues).fill( LinearGradient(gradient: Gradient(colors: [.green.opacity(0.7), .green.opacity(0.2), .green.opacity(0)]),startPoint: .top,endPoint: .bottom)).frame(width: 150, height: 50)
                                Text("\(Float(stock.latestClose)!, specifier: "%.2f")")
                                    .foregroundColor(Color(red: 0.23921568627450981, green: 0.24705882352941178, blue: 0.3843137254901961))
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
                                    .foregroundColor(Color(red: 0.23921568627450981, green: 0.24705882352941178, blue: 0.3843137254901961))
                                Spacer()
                                LineChart(values: stock.closeValues).fill( LinearGradient(gradient: Gradient(colors: [.green.opacity(0.7), .green.opacity(0.2), .green.opacity(0)]),startPoint: .top,endPoint: .bottom)).frame(width: 150, height: 50)
                                Text("\(Float(stock.latestClose)!, specifier: "%.2f")")
                                    .foregroundColor(Color(red: 0.23921568627450981, green: 0.24705882352941178, blue: 0.3843137254901961))
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
