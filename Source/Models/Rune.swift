//
//  Rune.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 30.7.23..
//

import Foundation
import CoreData

public class Rune: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var symbol: String
    @NSManaged public var name: String
    @NSManaged public var meaning: MeaningTranslation // Use the Translation type
    @NSManaged public var sound: String
    @NSManaged public var index: Int16
    @NSManaged public var strophes: NSSet?
        
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
}

@objc(MeaningTranslation)
public class MeaningTranslation: NSObject, NSCoding {
    var english: [String]
    var russian: [String]

    init(english: [String], russian: [String]) {
        self.english = english
        self.russian = russian
    }

    public required convenience init?(coder aDecoder: NSCoder) {
        guard let english = aDecoder.decodeObject(forKey: "english") as? [String] else { return nil }
        guard let russian = aDecoder.decodeObject(forKey: "russian") as? [String] else { return nil }
        self.init(english: english, russian: russian)
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(english, forKey: "english")
        aCoder.encode(russian, forKey: "russian")
    }
    
    func generate(language: TranslationLanguage) -> String {
        // The meanings of the rune in the specified language
        let meanings: [String]
        
        // Switch on the language to determine which meanings to use
        switch language {
        case .english:
            meanings = self.english
        case .russian:
            meanings = self.russian
        }
        
        // Join the meanings with a comma and return the result
        return meanings.joined(separator: ", ")
    }
}
