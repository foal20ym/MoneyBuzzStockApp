//
//  ViewModifiers.swift
//  MoneyBuzz
//
//  Created by Alexander Forsanker on 12/5/22.
//

import SwiftUI

struct LoginViewButtonsModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .bold()
            .frame(width: 310, height: 40)
            .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235),Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .foregroundColor(.white)
            ).foregroundColor(.white)
    }
}

struct AccountViewButtonsModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .bold()
            .frame(width: 310, height: 40)
            .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [Color(red: 0.9215686274509803, green: 0.9215686274509803, blue: 0.9215686274509803),Color(red: 0.9215686274509803, green: 0.9215686274509803, blue: 0.9215686274509803)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .foregroundColor(.black)
            ).foregroundColor(.black)
    }
}

struct LoginViewBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        RoundedRectangle(cornerRadius: 30, style: .continuous).foregroundStyle(.linearGradient(colors: [Color(red: 0.3176470588235294, green:0.8,blue: 0.6941176470588235), Color(red: 0.3176470588235294, green: 0.8, blue: 0.6941176470588235)], startPoint: .topLeading,endPoint: .bottomTrailing)).frame(width: 1000, height: 400).rotationEffect(.degrees(135)).offset(y: -350)
    }
}

struct AccountViewBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        RoundedRectangle(cornerRadius: 30, style: .continuous).foregroundStyle(.linearGradient(colors: [Color(red: 0.9215686274509803, green: 0.9215686274509803, blue: 0.9215686274509803), Color(red: 0.9215686274509803, green: 0.9215686274509803, blue: 0.9215686274509803)], startPoint: .topLeading,endPoint: .bottomTrailing)).frame(width: 1000, height: 400).rotationEffect(.degrees(135)).offset(y: -350)
    }
}

extension View {
    
    func loginViewButtonsModifier () -> some View {
        modifier(LoginViewButtonsModifier())
    }
    
    func loginViewBackgroundModifier () -> some View {
        modifier(LoginViewBackgroundModifier())
    }
    
    func accountViewBackgroundModifier () -> some View {
        modifier(AccountViewBackgroundModifier())
    }
    
    func accountViewButtonsModifier () -> some View {
        modifier(AccountViewButtonsModifier())
    }
}
