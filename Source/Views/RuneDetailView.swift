//
//  RuneDetailView.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 30.7.23..
//

import SwiftUI

struct RuneDetailView: View {
    let rune: Rune
    let translationLanguage: TranslationLanguage
    
    @State private var selectedPoemIndex = 0
    
    var body: some View {
        ScrollView {
            VStack() {
                Text(rune.Symbol).font(.system(size: 90)).fontWeight(.bold)
                Divider()
                Group {
                    Text(rune.Name).font(.system(size: 30))
                    Text(rune.Meaning.generate(language: translationLanguage).capitalized)
                }
                Divider()
                Text("Sound: \(rune.Sound)")
                Divider()
                
                if let runePoems = rune.RunePoems, !runePoems.isEmpty {
                    Text("Rune Poems").font(.title)
                    
                    Picker("", selection: $selectedPoemIndex) {
                        ForEach(runePoems.indices, id: \.self) { index in
                            Text(runePoems[index].Origin).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    RunePoemsView(runePoem: runePoems[selectedPoemIndex], translationLanguage: translationLanguage)
                }
            }
        }
    }
}

struct RuneDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleRune = Rune(Symbol: "ᚠ", Name: "Fehu", Meaning: Meaning(English: ["cattle", "property", "wealth"], Russian: ["скот", "имущество", "богатство"]), Sound: "F", RunePoems: [])
        
        RuneDetailView(rune: sampleRune, translationLanguage: .english)
    }
}
