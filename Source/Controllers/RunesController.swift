//
//  RunesController.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 30.7.23..
//

import Foundation

// Class to control the word search functionality
class RunesController: ObservableObject {
    @Published var loadedRunes: [Rune] = []
    
    init() {
        loadRunesData()
    }
    
    func loadRunesData() {
        guard let fileURL = Bundle.main.url(forResource: "ElderFuthark", withExtension: "json") else {
            fatalError("Failed to locate ElderFuthark.json file.")
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let runes = try decoder.decode([Rune].self, from: data)
            loadedRunes = runes // Update the loadedWords property
        } catch {
            fatalError("Failed to load ElderFuthark.json: \(error)")
        }
    }
}
