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
    
    var body: some View {
        ScrollView {
            VStack() {
                Text(rune.Symbol).font(.system(size: 90)).fontWeight(.bold)
                Divider()
                Group {
                    Text(rune.Name).font(.system(size: 30))
                    
                    switch translationLanguage {
                    case .english:
                        Text(rune.Meaning.English.joined(separator: ", ").capitalized)
                    case .russian:
                        Text(rune.Meaning.Russian.joined(separator: ", ").capitalized)
                    }
                }
                Divider()
                Text("Sound: \(rune.Sound)")
                Divider()
                
                if rune.RunePoems != nil {
                    Section {
                        Text("Rune Poems").font(.title)
                        
                        ForEach(rune.RunePoems!) { poem in
                            RunePoemsView(runePoem: poem, translationLanguage: translationLanguage)
                            Divider()
                        }
                        
                    }.padding()
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
