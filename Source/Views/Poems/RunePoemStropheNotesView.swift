//
//  RunePoemStropheNotesView.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 13.8.23..
//

import SwiftUI

struct RunePoemStropheNotesView: View {    let notes: [Note]
    let translationLanguage: TranslationLanguage
    
    init(notes: [Note], translationLanguage: TranslationLanguage) {
        self.notes = notes.sorted { $0.index < $1.index }
        self.translationLanguage = translationLanguage
    }
    
    var body: some View {
        ForEach(notes, id: \.self) { note in
            HStack(alignment: .top) {
                VStack {
                    Text(note.text)
                        .lineLimit(nil) // Allow multiline
                        .layoutPriority(1) // High priority for this text
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                
                VStack {
                    if let translation = note.translation {
                        Text(translation.generate(language: translationLanguage))
                            .lineLimit(nil) // Allow multiline
                            .layoutPriority(1) // High priority for this text
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct RunePoemStropheNotesView_Previews: PreviewProvider {
    static var previews: some View {
        RunePoemStropheNotesView(notes: [], translationLanguage: TranslationLanguage.english)
    }
}
