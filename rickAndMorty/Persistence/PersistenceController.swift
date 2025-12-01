//
//  PersistenceController.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import UIKit
import CoreData

final class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "FavoriteCharacter")
        container.loadPersistentStores { desc, error in
            if let error = error {
                fatalError("Error loading Core Data store: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return container.viewContext
    }
}
