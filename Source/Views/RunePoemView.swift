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
                Text(poem.name).font(.title2)
                HStack {
                    Text("Original")
                    Text("Translation")
                }
                
                Divider()
                
                
                if let strophesSet = poem.strophes as? Set<Strophe> {
                    ForEach(Array(strophesSet), id: \.self) { strophe in
                        HStack {
                            VStack {
                                Text(strophe.text)
                            }
                            .frame(maxWidth: .infinity)
                            
                            VStack {
                                Text(strophe.translation.generate(language: .english))
                            }
                            .frame(maxWidth: .infinity)
                            
                        }
//                        StropheView(strophe: strophe, translationLanguage: translationLanguage)
                    }
                }
            }
        }
    }
}

struct RunePoemView_Previews: PreviewProvider {
    static var previews: some View {
        RunePoemView(poem: RunePoem.init(), translationLanguage: .english)
    }
}
