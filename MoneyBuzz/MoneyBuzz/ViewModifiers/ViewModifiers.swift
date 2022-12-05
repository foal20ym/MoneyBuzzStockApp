//
//  ViewModifiers.swift
//  MoneyBuzz
//
//  Created by Alexander Forsanker on 12/5/22.
//

import SwiftUI

struct LoginViewModifier: ViewModifier {
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

extension View {
    func loginViewModifier () -> some View {
        modifier(LoginViewModifier())
    }
}
