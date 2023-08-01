//
//  RunePoemsView.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 30.7.23..
//

import SwiftUI

struct RunePoemsView: View {
    let runePoem: RunePoem
    let translationLanguage: TranslationLanguage
    
    var body: some View {
        VStack {
            Text(runePoem.Name).font(.title2)
            
            HStack(alignment: .top) {
                VStack {
                    Text("Original")
                    Divider()
                    Text(runePoem.Text)
                    
                    if let notes = runePoem.Notes {
                        Divider()
                        Section {
                            Text("Notes:")
                            Text(notes.Primary)
                            
                            if let secondary = notes.Secondary {
                                Text(secondary)
                            }
                            
                        }.italic()
                    }
                }
                
                VStack {
                    Text("Translate")
                    Divider()
                    
                    if let runePoemTranslation = runePoem.Translation.generate(language: translationLanguage) {
                        Text(runePoemTranslation)
                    }
                    
                    if let notes = runePoem.Notes {
                        if let translation = notes.Translation {
                            Divider()
                            Section {
                                Text("Notes:")
                                
                                if let notesTranslation = translation.Primary.generate(language: translationLanguage) {
                                    Text(notesTranslation)
                                }
                                
                                if let secondary = translation.Secondary {
                                    if let notesTranslation = secondary.generate(language: translationLanguage) {
                                        Text(notesTranslation)
                                    }
                                }
                            }.italic()
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct RunePoemsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleRunePoem = RunePoem(Name: "RÚNALÉOÐ", Origin: "Anglo-Saxon", Text: "Feoh biþ frófor · fira gehwilcum; sceal þéah mann gehwilc · miclan hit dælan gif hé wille for dryhtne · dómes hléotan.", Translation: RunePoemTranslations(English: "Wealth is a comfort to every man, although every man must share it out greatly if he would obtain a portion of the Lord’s glory.", Russian: "Богатство — утешение всем людям, но должен человек каждый — щедро им делиться, если он хочет перед Господом славу обрести."), Notes: nil)
        
        RunePoemsView(runePoem: sampleRunePoem, translationLanguage: .english)
            .environment(\.sizeCategory, .large)
            .padding(.all)

    }
}
