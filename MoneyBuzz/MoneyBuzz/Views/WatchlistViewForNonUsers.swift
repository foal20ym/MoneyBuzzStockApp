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
                    loginViewModel.isLoggedIn.toggle()
                }
            }
        }
    }
    
    var content: some View {
        NavigationStack {
            Text("Your watchlist is empty!")
                .font(.title)
                .foregroundColor(Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235))
        }
        .navigationTitle("Watchlist")
    }
}

struct WatchlistViewForNonUsers_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistViewForNonUsers()
    }
}
