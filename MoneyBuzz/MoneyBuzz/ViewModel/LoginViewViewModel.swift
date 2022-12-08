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
    @Published var isLoggedIn = false
    private let context = PersistenceController.shared.container.viewContext
    static var userID = ""
    private var email: [UserEntity] = []
    @Published var isAuthError = false
    @Published var authErrorDescription = ""
    
    public func login(email: String, password: String){
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
    
    public func register(email: String, password: String) {
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
    
    public func signout(){
        do { try Auth.auth().signOut()
            self.isLoggedIn = false
        } catch let error {
            print(error)
        }
    }
    
    
    private func addToUserEntity(for userID: String) {
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
    
    func validatePassword(password: String) -> Bool {
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        guard texttest.evaluate(with: password) else { return false }
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        guard texttest1.evaluate(with: password) else { return false }
        
        
        return true
    }
    
    func loginBool(email: String, password: String) -> Bool{
        let containsAt = email.contains("@")
        let validPassword = validatePassword(password: password)
        
        guard containsAt && validPassword else { return false }
        
        return true
    }
    
    func registerBool(email: String, password: String) -> Bool{
        let containsAt = email.contains("@")
        let validPassword = validatePassword(password: password)
        
        guard containsAt && validPassword else { return false }
        
        return true
    }
}
