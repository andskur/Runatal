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
    @State private var isSettingsActive = false

    
    var settings: some View {
        Group {
            #if os(iOS)
            HStack(spacing: 4) {
                Spacer()
                Button(action: {isSettingsActive.toggle() }, label: {
                    Image(systemName: "xmark.circle")
                })
            }
            .padding(.trailing)
            #endif
            
            Form {
                Picker("Translation", selection: $menuController.translation) {
                    ForEach(TranslationLanguage.allCases, id: \.self) { translation in
                        Text(translation.rawValue.capitalized).tag(translation)
                    }
                }
            }
            .padding()
         }
         .padding()
    }
    
    var body: some View {
        #if os(iOS)
        Button(action: {isSettingsActive.toggle() }, label: {
            Spacer()
            Image(systemName: "gear")
                
        })
        .sheet(isPresented: $isSettingsActive) {
            settings
        }
        .padding(.trailing)
        #endif
        
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
                .navigationTitle("Poems")
            case .none:
                Text("Please select Runes or Rune Poems")
            }
        } detail: {
            switch selectedMenu {
            case .runes:
                if let rune = selectedRune {
                    RuneDetailView(rune: rune, translationLanguage: menuController.translation)
                }
            case .poems:
                if let poem = selectedRunePoem {
                    RunePoemView(poem: poem, translationLanguage: menuController.translation)
                }
            case .none:
                Text("Plese select rune / rune poem")
            }
        }
        .navigationSplitViewStyle(.balanced)
        #if os(macOS)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: { isSettingsActive.toggle() }, label: {
                    Image(systemName: "gear")
                })
                .sheet(isPresented: $isSettingsActive) {
                    HStack(spacing: 4) {
                        Spacer()
                        Button(action: {isSettingsActive.toggle() }, label: {
                            Image(systemName: "xmark.circle")
                        })
                    }
                    settings
                }
            }
        }
        #endif
        .onAppear {
            #if os(macOS)
            selectedRune = runesController.loadedRunes[0]
            selectedRunePoem = runesPoemController.loadedRunePoems[0]
            #else
            let isiPhone =  UIDevice.current.userInterfaceIdiom.rawValue == 0 ? true : false
            
            if !isiPhone {
                selectedRune = runesController.loadedRunes[0]
                selectedRunePoem = runesPoemController.loadedRunePoems[0]
            }
            #endif
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
