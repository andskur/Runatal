//
//  RuneStrophesView.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 7.8.23..
//

import SwiftUI

struct RuneStrophesView: View {
    let strophes: [Strophe]
    let translationLanguage: TranslationLanguage
    @State private var selectedStropheIndex: Int = 0
    
    init(strophes: [Strophe], translationLanguage: TranslationLanguage) {
        self.strophes = strophes.sorted { $0.runePoem.name < $1.runePoem.name }
        self.translationLanguage = translationLanguage
    }
    
    var selectedStrophe: Strophe? {
        guard strophes.indices.contains(selectedStropheIndex) else {
            return nil
        }
        return strophes[selectedStropheIndex]
    }
    
    var body: some View {
        Picker("", selection: $selectedStropheIndex) {
            ForEach(strophes.indices, id: \.self) { index in
                Text(strophes[index].runePoem.origin).tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: strophes.count) { _ in
            selectedStropheIndex = 0 // Reset the selected index when strophes change
        }
        
        if let strophe = selectedStrophe {
            RuneStropheView(strophe: strophe, translationLanguage: translationLanguage)
        } else {
            Text("No strophe selected")
        }
    }
}


struct RuneStrophesView_Previews: PreviewProvider {
    static var previews: some View {
        RuneStrophesView(strophes: [], translationLanguage: TranslationLanguage.english)
    }
}
