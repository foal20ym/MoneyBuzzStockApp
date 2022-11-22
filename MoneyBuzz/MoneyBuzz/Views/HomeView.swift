//
//  HomeView.swift
//  MoneyBuzz
//
//  Created by Alexander Forsanker on 11/22/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("\(Image(systemName: "globe")) World indexes").font(.title).bold().foregroundColor(Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235))
                ForEach(0...5, id: \.self) { number in
                    HStack {
                        Text("Ticker")
                        
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 150)
                        
                        VStack{
                            Text("Value")
                            Text("Change")
                        }
                    }
                    .background(Color(red: 0.9215686274509803, green: 0.9215686274509803, blue: 0.9215686274509803))
                }
            }
            .scrollContentBackground(.hidden)
            
            List {
                Text("\(Image(systemName: "eurosign")) Currencies").font(.title).bold().foregroundColor(Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235))
                ForEach(0...5, id: \.self) { number in
                    HStack {
                        Text("Ticker")
                        
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 150)
                        
                        VStack{
                            Text("Value")
                            Text("Change")
                        }
                    }
                    .background(Color(red: 0.9215686274509803, green: 0.9215686274509803, blue: 0.9215686274509803))
                }
            }
            .scrollContentBackground(.hidden)
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
