//
//  NewsView.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-24.
//

import SwiftUI

struct NewsView: View {
    @ObservedObject var viewModel = NewsDataViewModel()
    @State private var showSheet = false
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(Color(#colorLiteral(red: 0.3176470588, green: 0.8, blue: 0.6948974729, alpha: 1)))]
    }
    var body: some View {
        NavigationStack {
                ForEach(0..<3) {
                    displayNews(ix: $0)
                }
            .padding()
            Spacer()
                .navigationTitle("News")
        }
    }
    
    func displayNews(ix: Int) -> some View {
        VStack {
            ForEach(viewModel.news) { element in
                
                HStack {
                    Text("\(element.data[ix].title)")
                        .font(.title3)
                    Spacer()
                }
                .onTapGesture {
                    showSheet.toggle()
                }
                .sheet(isPresented: $showSheet) {
                    Text("\(element.data[ix].title)")
                        .font(.largeTitle)
                        .padding()
                    Text("\(element.data[ix].description)")
                    
                }
                .foregroundColor(Color(red: 0.23921568627450981, green: 0.24705882352941178, blue: 0.3843137254901961))
                
                
                VStack {
                    HStack {
                        Text("\(element.data[ix].source)")
                        Spacer()
                        Text(viewModel.dateConverter(rawDate: element.data[ix].published_at))
                    }
                    .padding(.bottom, 15.0)
                    
                    
                    
                    .foregroundColor(Color(red: 0.6705882352941176, green: 0.6705882352941176, blue: 0.6705882352941176))
                    .padding(.top, 3.0)
                }
            }
            
        }
    }
    
    
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
