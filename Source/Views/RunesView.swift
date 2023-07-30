//
//  ContentView.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 30.7.23..
//

import SwiftUI


struct ContentView: View {
    @StateObject private var controller = RunesController()
    @State private var selectedRune: Rune?
        
    var body: some View {
        NavigationSplitView {
            List(
                controller.loadedRunes,
                selection: $selectedRune
            ) { rune in
                NavigationLink(value: rune) {
                    Text("\(rune.Symbol) - \(rune.Name)")
                }
            }
            .navigationTitle("ᚠᚢᚦᚨᚱᚲ")
        } detail: {
            ZStack {
                if let rune = selectedRune {
                    RuneDetailView(rune: rune)
                } else {
                    Text("Nothing Selected")
                }
            }
        }
        .onAppear {
            #if os(macOS)
            selectedRune = controller.loadedRunes[0]
            #endif
        }
    }
}
