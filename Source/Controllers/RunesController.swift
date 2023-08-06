//
//  RunesController.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 30.7.23..
//

import Foundation
import CoreData

// Enum to represent the different translation languages supported by the app
enum TranslationLanguage: String, CaseIterable {
    case english
    case russian
}

// Class to manage the state and behavior of the runes in the app
class RunesController: ObservableObject {
    // Published property to hold the current translation language, which will cause the view to update when it changes
    @Published var translation: TranslationLanguage = .russian
    // Published property to hold the loaded runes, which will cause the view to update when it changes
    @Published var loadedRunes: [Rune] = []
    
    let context = CoreDataManager.shared.viewContext
    
    // Initializer to load the runes data when a new instance of RunesController is created
    init() {
        loadRunesData()
//        loadPoems()
    }
    
    // Function to load the runes data from the JSON file
    func loadRunesData() {
        let request : NSFetchRequest<Rune> = NSFetchRequest(entityName: "Rune")
        let sort = NSSortDescriptor(key: #keyPath(Rune.index), ascending: true)
        request.sortDescriptors = [sort]

        do {
            let results = try context.fetch(request)
//            for r in results {
//                print(r.name)
//                print(r.meaning.english)

//                if let strophes = r.strophes as? Set<Strophe> {
//                    for s in strophes {
//                        print(s.runePoem.name)
//                        print(s.text)
//                        print(s.translation.english)
//                    }
//                }
//            }

            loadedRunes = results
        }
        catch let error as NSError{
            fatalError("Failed to load database: \(error)")
        }
    }
    
    func loadPoems() {
        let request : NSFetchRequest<RunePoem> = NSFetchRequest(entityName: "RunePoem")
        
        do {
            let results = try context.fetch(request)
            for r in results {
                print(r.name)
                print(r.origin)
                
                if let strophes = r.strophes as? Set<Strophe> {
                    for s in strophes {
                        print(s.text)
                        print(s.translation.english)
                    }
                }
            }

        }
        catch let error as NSError{
            fatalError("Failed to load database: \(error)")
        }
    }
}

