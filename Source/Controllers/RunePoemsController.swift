//
//  RunePoemsController.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 11.8.23..
//

import Foundation
import CoreData


class RunePoemsController: ObservableObject {
    @Published var loadedRunePoems: [RunePoem] = []
    
    let context = CoreDataManager.shared.viewContext
    
    init() {
        loadPoems()
    }
    
    func loadPoems() {
        let request : NSFetchRequest<RunePoem> = NSFetchRequest(entityName: "RunePoem")
        let sort = NSSortDescriptor(key: #keyPath(RunePoem.origin), ascending: true)
        request.sortDescriptors = [sort]

        
        do {
            let results = try context.fetch(request)
            loadedRunePoems = results
        }
        catch let error as NSError{
            fatalError("Failed to load database: \(error)")
        }
    }
}
