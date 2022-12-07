//
//  AccountView.swift
//  MoneyBuzz
//
//  Created by Alexander Forsanker on 12/2/22.
//

import SwiftUI
import Firebase

struct AccountView: View {
    @ObservedObject private var loginViewViewModel = LoginViewViewModel()
    @State private var isLoggedIn = true
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(Color(red: 0.3703474402, green: 0.8287841678, blue: 0.747587502))]
    }
    var body: some View {
        NavigationStack {
            if isLoggedIn {
                loggedin
            } else {
                LoginView()
            }
        }
    }
    var loggedin: some View {
        NavigationStack {
            let user = Auth.auth().currentUser
            let userEmail = Auth.auth().currentUser?.email
            let userID = Auth.auth().currentUser?.uid
            Text("Email: \(userEmail ?? "Firebase error; FatalError(connection)")")
            Text("UserID: \(userID ?? "Firebase error; FatalError(connection)")")
            Button {
                loginViewViewModel.signout()
                isLoggedIn = false
                
            } label: {
                Text("Sign out!").loginViewModifier()
            }.padding(.top).offset(y: 110)
        }
        .navigationTitle("Account info").frame(alignment: .center)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
