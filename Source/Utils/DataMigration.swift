//
//  File.swift
//  OldNorseDictionary
//
//  Created by Andrey Skurlatov on 6.8.23..
//


import CoreData

class DataMigration {
    static func migrateAll() {
        resetPersistentStore()
        migrateRunes()
        migrateRunePoems()
    }
    
    static func resetPersistentStore() {
        let context = CoreDataManager.shared.viewContext

        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Strophe")
        let deleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)

        do {
            try context.execute(deleteRequest1)
        } catch let error as NSError {
            print("Failed to migrate data: \(error)")
        }

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RunePoem")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Failed to migrate data: \(error)")
        }
        
//        let fetchRequest2: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Rune")
//        let deleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
//
//        do {
//            try context.execute(deleteRequest2)
//        } catch let error as NSError {
//            print("Failed to migrate data: \(error)")
//        }
    }

    
    static func migrateRunes() {
        let userDefaults = UserDefaults.standard
        let migrationKey = "hasMigratedRunes"

        // Check if the migration has already been performed
        if userDefaults.bool(forKey: migrationKey) {
            print("Migration already performed; skipping.")
            return
        }

        // Step 2: Read the JSON File
        guard let url = Bundle.main.url(forResource: "ElderFuthark", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            let runesData = try jsonDecoder.decode([RuneJSON].self, from: data)
            
            // Step 3: Set Up Core Data Context
            let context = CoreDataManager.shared.viewContext
            
            var index: Int16 = 0
            
            // Step 4: Create Core Data Rune Objects
            for runeData in runesData {
                let rune = NSEntityDescription.insertNewObject(forEntityName: "Rune", into: context) as! Rune
                rune.symbol = runeData.Symbol
                rune.name = runeData.Name
                rune.sound = runeData.Sound
                rune.index = index
                
                // Assuming runeData is the JSON object for a rune
                let translation = MeaningTranslation(english: runeData.Meaning.English, russian: runeData.Meaning.Russian)
                rune.setValue(translation, forKey: "meaning")
                
                index += 1
            }
            
            // Step 5: Save the Context
            try context.save()

            // Set the flag to indicate that the migration has been performed
            userDefaults.set(true, forKey: migrationKey)
        } catch {
            print("Failed to migrate data: \(error)")
        }
    }
    
    static func migrateRunePoems() {
        let userDefaults = UserDefaults.standard
        let migrationKey = "hasMigratedRunePoems"

        // Check if the migration has already been performed
//        if userDefaults.bool(forKey: migrationKey) {
//            print("Rune Poems migration already performed; skipping.")
//            return
//        }
        

        // Step 2: Read the JSON File
        guard let url = Bundle.main.url(forResource: "RunePoems", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            let runePoemsData = try jsonDecoder.decode([RunePoemJSON].self, from: data)
            
            // Step 3: Set Up Core Data Context
            let context = CoreDataManager.shared.viewContext
            
            // Step 1: Load existing Rune objects
            var runeDictionary: [String: Rune] = [:]
            let runesFetchRequest = NSFetchRequest<Rune>(entityName: "Rune")
            let runes = try context.fetch(runesFetchRequest)
            for rune in runes {
                runeDictionary[rune.symbol] = rune
            }
            
            // Step 4: Create Core Data Rune Poem and Strophe Objects
            for runePoemData in runePoemsData {
                let runePoem = NSEntityDescription.insertNewObject(forEntityName: "RunePoem", into: context) as! RunePoem
                runePoem.name = runePoemData.name
                runePoem.origin = runePoemData.origin
                
                for stropheData in runePoemData.strophes {
                    let strophe = NSEntityDescription.insertNewObject(forEntityName: "Strophe", into: context) as! Strophe
                    strophe.text = stropheData.text
                    strophe.translation = Translation(english: stropheData.translation.english, russian: stropheData.translation.russian)
                    strophe.index = stropheData.index
                    strophe.id = UUID()
                    strophe.runePoem = runePoem
                    
                    if let stropheRunes = stropheData.runes {
                        for runeSymbol in stropheRunes {
                            if let rune = runeDictionary[runeSymbol] {
                                strophe.addToRunes(rune)
                            }
                        }
                    }
                }
            }
            
            // Step 5: Save the Context
            try context.save()

            // Set the flag to indicate that the migration has been performed
            userDefaults.set(true, forKey: migrationKey)
        } catch {
            print("Failed to migrate Rune Poems data: \(error)")
        }
    }

}

struct RuneJSON: Decodable {
    let Symbol: String
    let Name: String
    let Meaning: MeaningJSON
    let Sound: String
}

struct MeaningJSON: Decodable {
    let English: [String]
    let Russian: [String]
}

struct RunePoemJSON: Decodable {
    let name: String
    let origin: String
    let strophes: [StropheJSON]
}

struct StropheJSON: Decodable {
    let text: String
    let translation: TranslationJSON
    let index: Int16
    let runes: [String]?
}

struct TranslationJSON: Decodable {
    let english: String
    let russian: String
}
