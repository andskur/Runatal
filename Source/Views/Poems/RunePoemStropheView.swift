//
//  RunePoemStropheView.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 13.8.23..
//

import SwiftUI

struct RunePoemStropheView: View {
    let strophe: Strophe
    let translationLanguage: TranslationLanguage
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack {
                    Text(strophe.text).italic()
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                
                VStack {
                    Text(strophe.translation.generate(language: translationLanguage)).italic()
                }
                .frame(maxWidth: .infinity)
                
            }
            
            if let notes = strophe.notes as? Set<Note> {
                if notes.count > 0 {
                    Divider()
                    RunePoemStropheNotesView(notes: Array(notes), translationLanguage: translationLanguage)
                }
            }
        }
        .padding()
    }
}

struct RunePoemStropheView_Previews: PreviewProvider {
    static var previews: some View {
        RunePoemStropheView(strophe: Strophe.init(), translationLanguage: TranslationLanguage.english)
    }
}
