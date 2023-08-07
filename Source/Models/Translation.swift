//
//  Translation.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 7.8.23..
//

import Foundation

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


@objc(Translation)
public class Translation: NSObject, NSCoding {
    var english: String
    var russian: String
    
    init(english: String, russian: String) {
        self.english = english
        self.russian = russian
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        guard let english = aDecoder.decodeObject(forKey: "english") as? String else { return nil }
        guard let russian = aDecoder.decodeObject(forKey: "russian") as? String else { return nil }
        self.init(english: english, russian: russian)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(english, forKey: "english")
        aCoder.encode(russian, forKey: "russian")
    }
    
    func generate(language: TranslationLanguage) -> String {
        // Switch on the language to determine which translation to use
        switch language {
        case .english:
            return self.english
        case .russian:
            return self.russian
        }
    }
}
