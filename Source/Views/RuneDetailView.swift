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
                Text(rune.symbol).font(.system(size: 90)).fontWeight(.bold)
                Divider()
                Group {
                    Text(rune.name).font(.system(size: 30))
                    Text(rune.meaning.generate(language: translationLanguage).capitalized)
                }
                Divider()
                Text("Sound: \(rune.sound)")
                Divider()
                
                if let strophesSet = rune.strophes as? Set<Strophe> {
                    RuneStrophesView(strophes: Array(strophesSet), translationLanguage: translationLanguage)
                }
            }
        }
    }
}

struct RuneDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RuneDetailView(rune: Rune.init(), translationLanguage: .english)
    }
}
