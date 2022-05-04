//
//  ToDoAppSwiftUIApp.swift
//  ToDoAppSwiftUI
//
//  Created by Hamza Azhar on 08/04/2022.
//

import SwiftUI

@main
struct ToDoAppSwiftUIApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage ("isDarkMode") var isDarkMode: Bool = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
