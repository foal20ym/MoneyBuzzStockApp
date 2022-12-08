//
//  IndividualStockView.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-29.
//

import SwiftUI

struct IndividualStockView: View {
    @ObservedObject var companyDataViewModel = CompanyOverviewViewModel()
    @State var stock: StockData
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                VStack {
                    HStack {
                        Text(companyDataViewModel.ticker)
                            .font(.title)
                            .bold()
                            .padding(.leading, 20)
                            .foregroundColor(Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235))
                        Text(companyDataViewModel.name)
                            .padding(.top, 5.0)
                            .foregroundColor(Color(red: 0.6705882352941176, green: 0.6705882352941176, blue: 0.6705882352941176))
                        Spacer()
                    }
                    Divider()
                    VStack {
                        HStack {
                            Text("\(Float(stock.latestClose)!, specifier: "%.2f")")
                                .bold()
                                .padding(.leading, 20)
                            Spacer()
                        }
                        .foregroundColor(Color(red: 0.23921568627450981, green: 0.24705882352941178, blue: 0.3843137254901961))
                        HStack {
                            Text(companyDataViewModel.exchange)
                            Text("•")
                            Text(companyDataViewModel.currency)
                            Spacer()
                        }
                        .padding(.leading, 20)
                        .foregroundColor(Color(red: 0.6705882352941176, green: 0.6705882352941176, blue: 0.6705882352941176))
                        
                    }
                    Divider()
                    GraphChartShape(graphDataPoints: companyDataViewModel.normalizeDataPointsForGraph(for: stock.graphDataPoints))
                        .stroke(lineWidth: 1.5)
                        .foregroundColor(Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235))
                        .frame(width: 393, height: 150)
                        .padding()
                        .shadow(radius: 2)
                    Divider()
                    HStack {
                        VStack(alignment: .listRowSeparatorLeading) {
                            Text("Open")
                                .padding(.bottom, 1.0)
                            Text("High")
                                .padding(.bottom, 1.0)
                            Text("Low")
                                .padding(.bottom, 1.0)
                            Text("Close")
                                .padding(.bottom, 1.0)
                            Text("Volume")
                        }
                        .foregroundColor(Color(red: 0.6705882352941176, green: 0.6705882352941176, blue: 0.6705882352941176))
                        .padding(.leading, 20)
                        VStack(alignment: .listRowSeparatorLeading) {
                            Text("\(Float(stock.latestOpen)!, specifier: "%.2f")")
                                .padding(.bottom, 1.0)
                                .bold()
                            Text("\(Float(stock.latestHigh)!, specifier: "%.2f")")
                                .padding(.bottom, 1.0)
                                .bold()
                            Text("\(Float(stock.latestLow)!, specifier: "%.2f")")
                                .padding(.bottom, 1.0)
                                .bold()
                            Text("\(Float(stock.latestClose)!, specifier: "%.2f")")
                                .padding(.bottom, 1.0)
                                .bold()
                            Text(stock.latestVolume)
                                .bold()
                        }
                        .foregroundColor(Color(red: 0.23921568627450981, green: 0.24705882352941178, blue: 0.3843137254901961))
                        Spacer()
                    }
                    Divider()
                    Text(companyDataViewModel.description)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .padding(.leading, 5.0)
                        .foregroundColor(Color(red: 0.23921568627450981, green: 0.24705882352941178, blue: 0.3843137254901961))
                    Divider()
                }
            }
            .onAppear {
                companyDataViewModel.loadCompanyData(for: stock.metaData.symbol)
            }
        }
    }
}

/*struct IndividualStockView_Previews: PreviewProvider {
 static var previews: some View {
 IndividualStockView(stock)
 }
 }*/

