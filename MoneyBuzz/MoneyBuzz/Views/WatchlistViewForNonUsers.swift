//
//  WatchlistViewForNonUsers.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-12-07.
//

import SwiftUI
import Firebase
// Test@gmail.com
struct WatchlistViewForNonUsers: View {
    @ObservedObject var loginViewModel = LoginViewViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(Color(red: 0.3703474402, green: 0.8287841678, blue: 0.747587502))]
    }
    
    var body: some View {
        NavigationStack {
            if loginViewModel.isLoggedIn {
                WatchlistView()
            } else {
                content
            }
        }
        .onAppear {
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    loginViewModel.isLoggedIn = true
                } else {
                    loginViewModel.isLoggedIn = false
                }
            }
        }
    }
    
    var content: some View {
        
        NavigationStack {
            Text("Please sign in or sign up to create a watchlist")
                .multilineTextAlignment(.center)
                .font(.title)
                .foregroundColor(Color(red: 0.23921568627450981, green: 0.24705882352941178, blue: 0.3843137254901961))
        }
        .navigationTitle("Watchlist")
    }
}

struct WatchlistViewForNonUsers_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistViewForNonUsers()
    }
}
