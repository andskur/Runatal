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
    
    init(strophe: Strophe, translationLanguage: TranslationLanguage) {
        print("KONYA")
        
        self.strophe = strophe
        self.translationLanguage = translationLanguage
        
        print(strophe.text)
    }
    
    var body: some View {
        VStack {
            Text(strophe.runePoem.name).font(.title2)
            
            HStack(alignment: .top) {
                VStack {
                    Text("Original")
                    Divider()
                    Text(strophe.text)
                }
                
                VStack {
                    Text("Translate")
                    Divider()
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
