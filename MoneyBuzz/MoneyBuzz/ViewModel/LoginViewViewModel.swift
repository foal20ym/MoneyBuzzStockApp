//
//  LoginViewViewModel.swift
//  MoneyBuzz
//
//  Created by Alexander Forsanker on 12/2/22.
//

import Foundation
import Firebase

final class LoginViewViewModel: ObservableObject {
    @Published var isLoggedIn = false
    
    func login(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.isLoggedIn = true
            }
        }
    }
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    func signout(){
        do { try Auth.auth().signOut()
            isLoggedIn = false
        } catch let error {
            print(error)
        }
    }
}
