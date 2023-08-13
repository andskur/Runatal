//
//  RunatalWatchOsApp.swift
//  RunatalWatchOs Watch App
//
//  Created by Andrey Skurlatov on 1.8.23..
//

import SwiftUI

@main
struct RunatalWatchOs_Watch_AppApp: App {
    init() {
        DataMigration.migrateAll()
    }
    
    var body: some Scene {
        WindowGroup {
            RunesListWatchView()
        }
    }
}
