//
//  StropheView.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 7.8.23..
//

import SwiftUI

struct StropheView: View {
    let strophe: Strophe
    let translationLanguage: TranslationLanguage
    
    var body: some View {
        VStack {
            Text(strophe.runePoem.name).font(.title2)
            
            HStack(alignment: .top) {
                VStack {
                    Text("Original")
                    Divider()
                    Text(strophe.text)
                        .lineLimit(nil) // Allow multiline
                        .layoutPriority(1) // High priority for this text
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("Translate")
                    Divider()
                    Text(strophe.translation.generate(language: translationLanguage))
                        .lineLimit(nil) // Allow multiline
                        .layoutPriority(1) // High priority for this text
                }
                .frame(maxWidth: .infinity)
            }
            
            if let notes = strophe.notes as? Set<Note> {
                if notes.count > 0 {  
                    NotesView(notes: Array(notes), translationLanguage: translationLanguage)
                }
            }
        }
        .padding()
    }
}




struct StropheView_Previews: PreviewProvider {
    static var previews: some View {
        StropheView(strophe: Strophe.init(), translationLanguage: TranslationLanguage.english)
    }
}
