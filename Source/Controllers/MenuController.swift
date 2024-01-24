//
//  MenuController.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 11.8.23..
//

import Foundation

enum MenuItem: String, CaseIterable {
    case runes
    case poems
}

// Enum to represent the different translation languages supported by the app
enum TranslationLanguage: String, CaseIterable {
    case english
    case russian
}

class MenuController: ObservableObject {
    // Published property to hold the current translation language, which will cause the view to update when it changes
    @Published var translation: TranslationLanguage = .english
}
