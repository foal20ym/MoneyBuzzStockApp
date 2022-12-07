//
//  LoginView.swift
//  MoneyBuzz
//
//  Created by Alexander Forsanker on 12/2/22.
//
import SwiftUI
import CoreData
import Firebase

// Test@gmail.com
// Testgmail

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    @ObservedObject public var loginViewViewModel = LoginViewViewModel()
    
    var body: some View {
        if loginViewViewModel.isLoggedIn {
            AccountView()
        } else {
            content
        }
    }
    
    var content: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.9215686274509803, green: 0.9215686274509803, blue: 0.9215686274509803)
                RoundedRectangle(cornerRadius: 30, style: .continuous).foregroundStyle(.linearGradient(colors: [Color(red: 0.3176470588235294, green:0.8,blue: 0.6941176470588235), Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235)], startPoint: .topLeading,endPoint: .bottomTrailing)).frame(width: 1000, height: 400).rotationEffect(.degrees(135)).offset(y: -350)
                VStack(spacing: 20) {
                    Text("Welcome").foregroundColor(.white).font(.system(size: 40, weight: .bold, design: .rounded)).offset(x: -100, y: -100)
                    TextField("",text:$email).foregroundColor(.white).textFieldStyle(.plain).disableAutocorrection(true).autocapitalization(.none).placeholder(when: email.isEmpty) {Text("Email").foregroundColor(.white).bold()}
                    Rectangle().frame(width: 350, height: 1).foregroundColor(.white)
                    SecureField("", text: $password).foregroundColor(.white).textFieldStyle(.plain).placeholder(when: password.isEmpty) {Text("Password").foregroundColor(.white).bold()}
                    Rectangle().frame(width: 350, height: 1).foregroundColor(.white)
                    Button {
                        loginViewViewModel.login(email: email, password: password)
                    } label: {
                        Text("Sign in").loginViewModifier()
                    }.padding(.top).offset(y: 110)
                        .alert("\(loginViewViewModel.authErrorDescription)", isPresented: $loginViewViewModel.isAuthError) {
                            Button("OK", role: .cancel) { }
                        }
                    Button {
                        loginViewViewModel.register(email: email, password: password)
                    } label: {
                        Text("Don't have an account? Sign up!").loginViewModifier()
                    }.padding(.top).offset(y: 110)
                        .alert("\(loginViewViewModel.authErrorDescription)", isPresented: $loginViewViewModel.isAuthError) {
                            Button("OK", role: .cancel) { }
                        }
                }.frame(width: 350).onAppear {
                    Auth.auth().addStateDidChangeListener { auth, user in
                        if user != nil {
                            loginViewViewModel.isLoggedIn.toggle()
                        }
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
