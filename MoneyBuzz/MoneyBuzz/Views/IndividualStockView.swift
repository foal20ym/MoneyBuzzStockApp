//
//  IndividualStockView.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-29.
//

import SwiftUI

struct IndividualStockView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                VStack {
                    HStack {
                        Text("AAPL")
                        
                            .font(.title)
                            .bold()
                            .padding([.top, .leading], 30.0)
                            .foregroundColor(Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235))
                        Text("Apple Inc")
                            .padding(.top, 35.0)
                            .foregroundColor(Color(red: 0.6705882352941176, green: 0.6705882352941176, blue: 0.6705882352941176))
                        Spacer()
                    }
                    Divider()
                    VStack {
                        HStack {
                            Text("150,53")
                                .bold()
                                .padding(.leading, 30.0)
                            
                            Spacer()
                        }
                        .foregroundColor(Color(red: 0.23921568627450981, green: 0.24705882352941178, blue: 0.3843137254901961))
                        HStack {
                            Text("NASDAQ")
                            Text("•")
                            Text("USD")
                            Spacer()
                        }
                        .padding(.leading, 30.0)
                        .foregroundColor(Color(red: 0.6705882352941176, green: 0.6705882352941176, blue: 0.6705882352941176))
                        
                    }
                    Divider()
                    Text("Graph Placeholder")
                        .frame(width: 400, height: 300)
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
                        .padding(.leading, 30.0)
                        VStack(alignment: .listRowSeparatorLeading) {
                            Text("150")
                                .padding(.bottom, 1.0)
                                .bold()
                            Text("150")
                                .padding(.bottom, 1.0)
                                .bold()
                            Text("150")
                                .padding(.bottom, 1.0)
                                .bold()
                            Text("150")
                                .padding(.bottom, 1.0)
                                .bold()
                            Text("15000")
                                .bold()
                        }
                        .foregroundColor(Color(red: 0.23921568627450981, green: 0.24705882352941178, blue: 0.3843137254901961))
                        Spacer()
                    }
                    Divider()
                    Text("Company Info PlaceHolder")
                        .frame(width: 400, height: 200)
                    Divider()
                }
                
            }
        }
    }
}

struct IndividualStockView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualStockView()
    }
}
