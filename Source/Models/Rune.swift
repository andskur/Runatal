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
    @NSManaged public var meaning: Translation // Use the Translation type
    @NSManaged public var sound: String
    @NSManaged public var index: Int16
    @NSManaged public var runePoems: NSSet?
    
    // You can also define convenience methods here if needed
    
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
}

@objc(Translation)
public class Translation: NSObject, NSCoding {    
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




// Struct to represent a rune
//struct RuneOld: Identifiable, Hashable, Decodable {
//    // Enum to represent the coding keys used in the JSON representation of a rune
//    private enum CodingKeys : String, CodingKey {
//        case Symbol, Name, Meaning, Sound, RunePoems
//    }
//
//    // Unique identifier for each rune
//    var id = UUID()
//    // The symbol of the rune
//    let Symbol: String
//    // The name of the rune
//    let Name: String
//    // The meaning of the rune
//    let Meaning: Meaning
//    // The sound of the rune
//    let Sound: String
//    // The poems associated with the rune
//    let RunePoems: [RunePoemOld]?
//}
//
//// Struct to represent the meaning of a rune
//struct Meaning: Hashable, Decodable {
//    // The meaning of the rune in English
//    let English: [String]
//    // The meaning of the rune in Russian
//    let Russian: [String]
//
//    // Function to generate the meaning of the rune in a specific language
//    func generate(language: TranslationLanguage) -> String {
//        // The meanings of the rune in the specified language
//        let meanings: [String]
//
//        // Switch on the language to determine which meanings to use
//        switch language {
//        case .english:
//            meanings = English
//        case .russian:
//            meanings = Russian
//        }
//
//        // Join the meanings with a comma and return the result
//        return meanings.joined(separator: ", ")
//    }
//}
