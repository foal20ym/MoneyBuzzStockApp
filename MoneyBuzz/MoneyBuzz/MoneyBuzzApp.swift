//
//  MoneyBuzzApp.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-21.
//

import SwiftUI
import Firebase

@main
struct MoneyBuzzApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
