//
//  Todo_AppApp.swift
//  Todo App
//
//  Created by Sergey Hrabrov on 16.07.2023.
//

import SwiftUI

@main
struct Todo_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}