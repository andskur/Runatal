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
        Text(runePoem.Name).font(.title2)
        if runePoem.Origin != nil {
            Text(runePoem.Origin!)
        }
        
        HStack(alignment: .top) {
            VStack {
                Text("Original")
                Divider()
                Text(runePoem.Text)
            }
            
            VStack {
                Text("Translate")
                Divider()
                
                switch translationLanguage {
                case .english:
                    Text(runePoem.Translation.English)
                case .russian:
                    Text(runePoem.Translation.Russian)
                }
            }
        }
    }
}

struct RunePoemsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleRunePoem = RunePoem(Name: "RÚNALÉOÐ", Origin: "Anglo-Saxon", Text: "Feoh biþ frófor · fira gehwilcum; sceal þéah mann gehwilc · miclan hit dælan gif hé wille for dryhtne · dómes hléotan.", Translation: RunePoemTranslations(English: "Wealth is a comfort to every man, although every man must share it out greatly if he would obtain a portion of the Lord’s glory.", Russian: "Богатство — утешение всем людям, но должен человек каждый — щедро им делиться, если он хочет перед Господом славу обрести."))
        
        RunePoemsView(runePoem: sampleRunePoem, translationLanguage: .english)
            .environment(\.sizeCategory, .large)
            .padding(.all)

    }
}
