//
//  RuneStrophesView.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 7.8.23..
//

import SwiftUI

struct RuneStrophesView: View {
    let strophes: [Strophe]
    let translationLanguage: TranslationLanguage
    @State private var selectedStrophe: Strophe
    
    init(strophes: [Strophe], translationLanguage: TranslationLanguage) {
        print("JOPA")
        
        self.strophes = strophes
        self.selectedStrophe = strophes.first!
        self.translationLanguage = translationLanguage
        
        print(selectedStrophe.runePoem.name)
        print(selectedStrophe.text)
    }
    
    var body: some View {
        Picker("", selection: $selectedStrophe) {
            ForEach(strophes) {strophe in
                Text(strophe.runePoem.origin).tag(strophe)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        
        StropheView(strophe: selectedStrophe, translationLanguage: translationLanguage)
    }
}

struct RuneStrophesView_Previews: PreviewProvider {
    static var previews: some View {
        RuneStrophesView(strophes: [], translationLanguage: TranslationLanguage.english)
    }
}
