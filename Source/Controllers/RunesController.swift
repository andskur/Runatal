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
    @Published var loadedRunes: [RuneOld] = []
    
    @Published var loadedRunesNew: [Rune] = []
    
    let context = CoreDataManager.shared.viewContext
    
    // Initializer to load the runes data when a new instance of RunesController is created
    init() {
        loadRunesData()
        
        loadRunesDataNew()
    }
    
    
    func loadRunesDataNew() {
        let request : NSFetchRequest<Rune> = NSFetchRequest(entityName: "Rune")
        let sort = NSSortDescriptor(key: #keyPath(Rune.index), ascending: true)
        request.sortDescriptors = [sort]

        do {
            let results = try context.fetch(request)
            for r in results {
                print(r.name)
                print(r.meaning.english)
            }

            loadedRunesNew = results
        }
        catch let error as NSError{
            fatalError("Failed to load database: \(error)")
        }
    }
    
    // Function to load the runes data from the JSON file
    func loadRunesData() {
        // Get the URL for the JSON file in the app bundle
        guard let fileURL = Bundle.main.url(forResource: "ElderFuthark", withExtension: "json") else {
            fatalError("Failed to locate ElderFuthark.json file.")
        }
        
        do {
            // Load the data from the JSON file
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            // Decode the data into an array of Runes
            let runes = try decoder.decode([RuneOld].self, from: data)
            // Update the loadedRunes property with the decoded runes
            loadedRunes = runes
        } catch {
            // If an error occurs while loading or decoding the data, print the error and terminate the app
            fatalError("Failed to load ElderFuthark.json: \(error)")
        }
    }
}

