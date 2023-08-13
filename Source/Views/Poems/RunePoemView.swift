//
//  RunePoemView.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 11.8.23..
//

import SwiftUI

struct RunePoemView: View {
    let poem: RunePoem
    let translationLanguage: TranslationLanguage
    
    var body: some View {
        ScrollView {
            VStack {
                Group {
                    Text(poem.name).font(.title)
                    Text(poem.origin).font(.title2)
                }
                .padding()
                
                HStack {
                    Text("Original")
                    Divider()
                    Text("Translation")
                }
                
                Divider()
                
                
                if let strophesSet = poem.strophes as? Set<Strophe> {
                    RunePoemStrophesView(strophes: Array(strophesSet), translationLanguage: translationLanguage)
                }
            }
            .padding()
        }
    }
}

struct RunePoemView_Previews: PreviewProvider {
    static var previews: some View {
        RunePoemView(poem: RunePoem.init(), translationLanguage: .english)
    }
}
