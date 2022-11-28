//
//  ContentView.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color(red: 0.23921568627450981, green: 0.24705882352941178, blue: 0.3843137254901961))
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235))
        UITabBar.appearance().barTintColor = UIColor(Color(red: 0.23921568627450981, green: 0.24705882352941178, blue: 0.3843137254901961))
        //UITabBar.appearance().isTranslucent = false
    }
    
    var body: some View {
        TabView {
            /*HomeView() // Change to AccountInfoView when that view is done.
                .tabItem() {
                    Image(systemName: "person")
                    Text("Account")
                } */
            
            HomeView()
                .tabItem() {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            WatchlistView()
                .tabItem() {
                    Image(systemName: "list.clipboard")
                    Text("Watchlist")
                }
            NewsView()
                .tabItem() {
                    Image(systemName: "newspaper.fill")
                    Text("News")
                }
        }
        .accentColor(Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
