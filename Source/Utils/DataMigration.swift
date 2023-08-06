//
//  File.swift
//  OldNorseDictionary
//
//  Created by Andrey Skurlatov on 6.8.23..
//


import CoreData

class DataMigration {
    
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
            
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Rune")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

            do {
                try context.execute(deleteRequest)
            } catch let error as NSError {
                print("Failed to migrate data: \(error)")
            }
            
            var index: Int16 = 0
            
            // Step 4: Create Core Data Rune Objects
            for runeData in runesData {
                let rune = NSEntityDescription.insertNewObject(forEntityName: "Rune", into: context) as! Rune
                rune.symbol = runeData.Symbol
                rune.name = runeData.Name
                rune.sound = runeData.Sound
                rune.index = index
                
                // Assuming runeData is the JSON object for a rune
                let translation = Translation(english: runeData.Meaning.English, russian: runeData.Meaning.Russian)
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

}

struct RuneJSON: Decodable {
    let Symbol: String
    let Name: String
    let Meaning: MeaningJSON
    let Sound: String
    // Add other properties as needed
}

struct MeaningJSON: Decodable {
    let English: [String]
    let Russian: [String]
}
