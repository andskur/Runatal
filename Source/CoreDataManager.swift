//
//  CoreDataManager.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 6.8.23..
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    init() {
        // Register the custom transformers
        let meaningTransformer = MeaningTranslationToDataTransformer()
        ValueTransformer.setValueTransformer(meaningTransformer, forName: NSValueTransformerName("MeaningTranslationToDataTransformer"))
        
        let translationTransformer = TranslationToDataTransformer()
        ValueTransformer.setValueTransformer(translationTransformer, forName: NSValueTransformerName("TranslationToDataTransformer"))
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RunatalModel") // Replace with your Core Data model name
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

@objc(MeaningTranslationToDataTransformer)
class MeaningTranslationToDataTransformer: ValueTransformer {
    // Convert MeaningTranslation to Data
    override func transformedValue(_ value: Any?) -> Any? {
        guard let translation = value as? MeaningTranslation else { return nil }
        return try? NSKeyedArchiver.archivedData(withRootObject: translation, requiringSecureCoding: false)
    }

    // Convert Data to MeaningTranslation
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        do {
            let unarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
            unarchiver.requiresSecureCoding = false
            return unarchiver.decodeObject(of: MeaningTranslation.self, forKey: NSKeyedArchiveRootObjectKey)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}

@objc(TranslationToDataTransformer)
class TranslationToDataTransformer: ValueTransformer {
    // Convert Translation to Data
    override func transformedValue(_ value: Any?) -> Any? {
        guard let translation = value as? Translation else { return nil }
        return try? NSKeyedArchiver.archivedData(withRootObject: translation, requiringSecureCoding: false)
    }

    // Convert Data to Translation
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        do {
            let unarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
            unarchiver.requiresSecureCoding = false
            return unarchiver.decodeObject(of: Translation.self, forKey: NSKeyedArchiveRootObjectKey)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}
