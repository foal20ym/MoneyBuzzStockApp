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
        VStack(alignment: .listRowSeparatorLeading) {
            Text(selectedTitle.title)
                .font(.largeTitle)
                .padding(.leading, 4)
                .padding(.bottom, 12.0)
                .multilineTextAlignment(.leading)
        }
        Text(selectedTitle.description)
            .padding(.horizontal, 8.0)
            .multilineTextAlignment(.leading)
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(selectedTitle: .constant(SheetModel(title: "This is a fake title", description: "This is a fake description that says..")))
    }
}

