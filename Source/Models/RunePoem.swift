//
//  RunePoem.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 30.7.23..
//

import Foundation

struct RunePoem: Identifiable, Hashable, Decodable {
    private enum CodingKeys : String, CodingKey {
        case Name, Origin, Text, Translation, Notes
    }
    
    var id = UUID()
    
    let Name: String
    let Origin: String
    let Text: String
    let Translation: RunePoemTranslations
    let Notes: Notes?
}

struct RunePoemTranslations: Hashable, Decodable {
    let English: String?
    let Russian: String?
    
    
    func generate(language: TranslationLanguage) -> String? {
        var translation: String? = nil
        
        switch language {
        case .english:
            if let englishTranslation = English {
                translation = englishTranslation
            }
        case .russian:
            if let russianTranslation = Russian {
                translation = russianTranslation
            }
        }
        
        return translation
    }
}

struct Notes: Hashable, Decodable {
    let Primary: String
    let Secondary: String?
    let Translation: NoteTranslations?
}

struct NoteTranslations: Hashable, Decodable {
    let Primary: RunePoemTranslations
    let Secondary: RunePoemTranslations?
}
