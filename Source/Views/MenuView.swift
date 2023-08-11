//
//  MenuView.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 11.8.23..
//

import SwiftUI

struct MenuView: View {
    @State private var columnVisibility = NavigationSplitViewVisibility.all

    @StateObject private var menuController = MenuController()
    @StateObject private var runesController = RunesController()
    @StateObject private var runesPoemController = RunePoemsController()
    
    @State private var selectedMenu: MenuItem? = .runes
    @State private var selectedRune: Rune?
    @State private var selectedRunePoem: RunePoem?
    
    var body: some View {
        NavigationSplitView (columnVisibility: $columnVisibility) {
            List (MenuItem.allCases, id: \.rawValue, selection: $selectedMenu) { item in
                Text(item.rawValue.capitalized).tag(item)
            }
            .navigationTitle("Menu")
        } content: {
            switch selectedMenu {
            case .runes:
                List (
                    runesController.loadedRunes,
                    selection: $selectedRune
                ) { rune in
                    NavigationLink(value: rune) {
                        Text("\(rune.symbol) - \(rune.name)")
                    }
                }
                .navigationTitle("ᚠᚢᚦᚨᚱᚲ")
            case .poems:
                List (
                    runesPoemController.loadedRunePoems,
                    selection: $selectedRunePoem
                ) { poem in
                    NavigationLink(value: poem) {
                        Text("\(poem.origin) - \(poem.name)")
                    }
                }
                .navigationTitle("ᚠᚢᚦᚨᚱᚲ")
            case .none:
                Text("Please select Runes or Rune Poems")
            }
        } detail: {
            switch selectedMenu {
            case .runes:
                if let rune = selectedRune {
                    RuneDetailView(rune: rune, translationLanguage: .english)
                }
            case .poems:
                if let poem = selectedRunePoem {
                    RunePoemView(poem: poem, translationLanguage: .english)
                }
            case .none:
                Text("Plese select rune / rune poem")
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
