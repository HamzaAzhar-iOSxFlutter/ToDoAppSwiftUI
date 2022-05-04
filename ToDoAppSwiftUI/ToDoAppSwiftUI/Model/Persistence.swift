//
//  Persistence.swift
//  ToDoAppSwiftUI
//
//  Created by Hamza Azhar on 08/04/2022.
//

import CoreData

struct PersistenceController {
    
    //MARK: - Persistent Controller
    static let shared = PersistenceController()
    
    //MARK: - Persistent Container
    let container: NSPersistentContainer

    //MARK: - Initialisation(Load the persistent store)
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ToDoAppSwiftUI")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    //MARK: - Preview
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.completion = false
            newItem.task = "Sample task \(i)"
            newItem.id = UUID()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
