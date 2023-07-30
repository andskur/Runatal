//
//  RunePoem.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 30.7.23..
//

import Foundation

struct RunePoem: Identifiable, Hashable, Decodable {
    private enum CodingKeys : String, CodingKey {
        case Name, Text, Translation
    }
    
    var id = UUID()
    
    let Name: String
    let Text: String
    let Translation: RunePoemTranslations
}

struct RunePoemTranslations: Hashable, Decodable {
    let English: String
    let Russian: String
}
