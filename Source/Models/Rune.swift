//
//  Rune.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 30.7.23..
//

import Foundation

struct Rune: Identifiable, Hashable, Decodable {
    private enum CodingKeys : String, CodingKey {
        case Symbol, Name, Meaning, Sound, RunePoems
    }
    
    var id = UUID()
    let Symbol: String
    let Name: String
    let Meaning: Meaning
    let Sound: String
    
    let RunePoems: [RunePoem]?
}


struct Meaning: Hashable, Decodable {
    let English: [String]
    let Russian: [String]
}
