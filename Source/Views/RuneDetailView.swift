//
//  RuneDetailView.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 30.7.23..
//

import SwiftUI

struct RuneDetailView: View {
    let rune: Rune
    
    var body: some View {
        VStack() {
            Text(rune.Symbol).font(.system(size: 80)).fontWeight(.bold)
            Divider()
            Group {
                Text(rune.Name).font(.system(size: 30))
                Text(rune.Meaning.English.joined(separator: ", ").capitalized)
            }
            Divider()
            Text("Sound: \(rune.Sound)")
        }
    }
}

struct RuneDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleRune = Rune(Symbol: "ᚠ", Name: "Fehu", Meaning: Meaning(English: ["cattle", "property", "wealth"], Russian: ["скот", "имущество", "богатство"]), Sound: "F")
        
        RuneDetailView(rune: sampleRune)
    }
}
