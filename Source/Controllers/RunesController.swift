//
//  RunesController.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 30.7.23..
//

import Foundation
import CoreData

// Class to manage the state and behavior of the runes in the app
class RunesController: ObservableObject {
    // Published property to hold the current translation language, which will cause the view to update when it changes
    @Published var loadedRunes: [Rune] = []
    
    let context = CoreDataManager.shared.viewContext
    
    // Initializer to load the runes data when a new instance of RunesController is created
    init() {
        loadRunesData()
    }
    
    // Function to load the runes data from the database
    func loadRunesData() {
        let request : NSFetchRequest<Rune> = NSFetchRequest(entityName: "Rune")
        let sort = NSSortDescriptor(key: #keyPath(Rune.index), ascending: true)
        request.sortDescriptors = [sort]

        do {
            let results = try context.fetch(request)
            loadedRunes = results
        }
        catch let error as NSError{
            fatalError("Failed to load database: \(error)")
        }
    }
}

