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
//        loadPoems()
    }
    
    func loadPoems() {
        let request : NSFetchRequest<RunePoem> = NSFetchRequest(entityName: "RunePoem")
        
        do {
            let results = try context.fetch(request)
//            for r in results {
//                if r.origin != "Icelandic" {
//                    continue
//                }
//
//                print(r.name)
//                print(r.origin)
//
//                if let strophes = r.strophes as? Set<Strophe> {
//                    for s in strophes {
//                        print(s.text)
//                        print(s.translation.english)
//
//                        if let notes = s.notes as? Set<Note> {
//                            for n in notes {
//                                print(n.text)
//
//                                if let t = n.translation {
//                                    print(t.english)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
            loadedRunePoems = results
        }
        catch let error as NSError{
            fatalError("Failed to load database: \(error)")
        }
    }
}
