//
//  RunePoemsView.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 30.7.23..
//

import SwiftUI

struct RunePoemsView: View {
    let runePoem: RunePoem
    
    var body: some View {
        Text(runePoem.Name).font(.title2)
        
        HStack(alignment: .top) {
            VStack {
                Text("Original")
                Divider()
                Text(runePoem.Text)
            }
            
            VStack {
                Text("Translate")
                Divider()
                Text(runePoem.Translation.English)
            }
        }
        
//        VStack {
//            HStack {
//                Text("Original")
//                Divider()
//                Text("Translate")
//            }
//            .font(.title3)
//            .padding()
//
//            HStack {
//                Text(runePoem.Text)
//                Divider()
//                Text(runePoem.Translation.English)
//            }
//        }

        
//        Grid() {
//            GridRow {
//                Section {
//                    Text("Original")
//                }
//                Section {
//                    Text("Translate")
//                }
//            }
//            GridRow {
//                Section {
//                    Text(runePoem.Text)
//                }
//                Divider()
//                Section {
//                    Text(runePoem.Translation.English)
//                }
//            }
//        }
    }
}

struct RunePoemsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleRunePoem = RunePoem(Name: "Anglo-Saxon", Text: "Feoh biþ frófor · fira gehwilcum; sceal þéah mann gehwilc · miclan hit dælan gif hé wille for dryhtne · dómes hléotan.", Translation: RunePoemTranslations(English: "Wealth is a comfort to every man, although every man must share it out greatly if he would obtain a portion of the Lord’s glory.", Russian: "Богатство — утешение всем людям, но должен человек каждый — щедро им делиться, если он хочет перед Господом славу обрести."))
        
        RunePoemsView(runePoem: sampleRunePoem)
            .environment(\.sizeCategory, .large)
            .padding(.all)
            
    }
}
