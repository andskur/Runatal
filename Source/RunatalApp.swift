//
//  RunatalApp.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 30.7.23..
//

import SwiftUI

@main
struct RunatalApp: App {
    init() {
        DataMigration.migrateRunes()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
