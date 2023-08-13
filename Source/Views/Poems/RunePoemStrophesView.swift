//
//  RunePoemStrophesView.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 13.8.23..
//

import SwiftUI

struct RunePoemStrophesView: View {
    let strophes: [Strophe]
    let translationLanguage: TranslationLanguage
    
    init(strophes: [Strophe], translationLanguage: TranslationLanguage) {
        self.strophes = strophes.sorted { $0.index < $1.index }
        self.translationLanguage = translationLanguage
    }
    
    var body: some View {
        ForEach(strophes, id: \.self) { strophe in
            RunePoemStropheView(strophe: strophe, translationLanguage: translationLanguage)
            Divider()
        }
    }
}

struct RunePoemStrophesView_Previews: PreviewProvider {
    static var previews: some View {
        RunePoemStrophesView(strophes: [], translationLanguage: TranslationLanguage.english)
    }
}
