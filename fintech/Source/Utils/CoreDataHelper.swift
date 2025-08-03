//
//  CoreDataHelper.swift
//  fintech
//
//  Created by Diogo on 31/07/2025.
//

import Foundation
import CoreData

class CoreDataHelper {
    static let shared = CoreDataHelper()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "Database") // Replace with your .xcdatamodeld name
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data stack failed: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }
}
