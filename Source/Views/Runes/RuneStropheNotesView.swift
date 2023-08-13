//
//  Notes.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 7.8.23..
//

import SwiftUI

struct RuneStropheNotesView: View {
    let notes: [Note]
    let translationLanguage: TranslationLanguage
    
    init(notes: [Note], translationLanguage: TranslationLanguage) {
        self.notes = notes.sorted { $0.index < $1.index }
        self.translationLanguage = translationLanguage
    }
    
    var body: some View {
        Divider()
        Text("Notes:").font(.title3)
        
        ForEach(notes, id: \.self) { note in
            HStack(alignment: .top) {
                VStack {
                    Text(note.text)
                        .lineLimit(nil) // Allow multiline
                        .layoutPriority(1) // High priority for this text
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    if let translation = note.translation {
                        Text(translation.generate(language: translationLanguage))
                            .lineLimit(nil) // Allow multiline
                            .layoutPriority(1) // High priority for this text
                    }
                }
                .frame(maxWidth: .infinity)
            }
            Divider()
        }
    }
}

struct Notes_Previews: PreviewProvider {
    static var previews: some View {
        RuneStropheNotesView(notes: [], translationLanguage: TranslationLanguage.english)
    }
}
