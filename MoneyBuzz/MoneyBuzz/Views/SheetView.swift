//
//  SheetView.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-28.
//

import SwiftUI

struct SheetModel {
    let title: String
    let description: String
}


struct SheetView: View {
    @Binding var selectedTitle: SheetModel
    var body: some View {
        HStack {
            Text(selectedTitle.title)
                .font(.largeTitle)
                .padding()
            Spacer()
        }
            Text(selectedTitle.description)
                .padding(.horizontal, 12.0)
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(selectedTitle: .constant(SheetModel(title: "This is a fake title", description: "This is a fake description that says..")))
    }
}
