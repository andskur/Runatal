//
//  RunePoem.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 30.7.23..
//

import Foundation

// Struct to represent a rune poem
struct RunePoem: Identifiable, Hashable, Decodable {
    // Enum to represent the coding keys used in the JSON representation of a rune poem
    private enum CodingKeys : String, CodingKey {
        case Name, Origin, Text, Translation, Notes
    }
    
    // Unique identifier for each rune poem
    var id = UUID()
    
    // The name of the rune poem
    let Name: String
    // The origin of the rune poem
    let Origin: String
    // The text of the rune poem
    let Text: String
    // The translation of the rune poem
    let Translation: RunePoemTranslations
    // The notes associated with the rune poem
    let Notes: Notes?
}

// Struct to represent the translation of a rune poem
struct RunePoemTranslations: Hashable, Decodable {
    // The translation of the rune poem in English
    let English: String?
    // The translation of the rune poem in Russian
    let Russian: String?
    
    // Function to generate the translation of the rune poem in a specific language
    func generate(language: TranslationLanguage) -> String? {
        // The translation of the rune poem in the specified language
        var translation: String? = nil
        
        // Switch on the language to determine which translation to use
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

// Struct to represent the notes associated with a rune poem
struct Notes: Hashable, Decodable {
    // The primary note
    let Primary: String
    // The secondary note
    let Secondary: String?
    // The translation of the notes
    let Translation: NoteTranslations?
}

// Struct to represent the translation of the notes associated with a rune poem
struct NoteTranslations: Hashable, Decodable {
    // The translation of the primary note
    let Primary: RunePoemTranslations
    // The translation of the secondary note
    let Secondary: RunePoemTranslations?
}
