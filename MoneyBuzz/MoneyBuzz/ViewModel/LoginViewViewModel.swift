//
//  LoginViewViewModel.swift
//  MoneyBuzz
//
//  Created by Alexander Forsanker on 12/2/22.
//

import Foundation
import Firebase
import CoreData

final class LoginViewViewModel: ObservableObject {
    @Published var  isLoggedIn = false
    private let context = PersistenceController.shared.container.viewContext
    static var userID = ""
    private var email: [UserEntity] = []
    @Published var isAuthError = false
    @Published var authErrorDescription = ""
    
    func loadFromCoreData() {
        do {
            email = try context.fetch(UserEntity.fetchRequest())
            for i in email {
                print("here comes the users: \(i)")
            }
        } catch {
            print(error)
        }
    }
    
    func login(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                self.isAuthError.toggle()
                self.authErrorDescription = error!.localizedDescription
                print(error!.localizedDescription)
            } else {
                self.isLoggedIn = true
            }
        }
        LoginViewViewModel.userID = email
        print("From LoginViewModel: \(LoginViewViewModel.userID)")
    }
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                self.isAuthError.toggle()
                self.authErrorDescription = error!.localizedDescription
                print(error!.localizedDescription)
                return
            }
        }
        LoginViewViewModel.userID = email
        addToUserEntity(for: email)
    }
    
    func signout(){
        do { try Auth.auth().signOut()
            self.isLoggedIn = false
        } catch let error {
            print(error)
        }
    }
    
    
    func addToUserEntity(for userID: String) {
        let newUser = UserEntity(context: context)
        guard userID != "Unknown ID" else {
            print("Error when fetching user ID")
            return
        }
        newUser.userID = userID
        
        do {
            try context.save()
        } catch {
            print("error when saving userID")
            print(error)
        }
    }
}
