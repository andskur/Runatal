//
//  RunesListView.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 11.8.23..
//

import SwiftUI

struct RunesListView: View {
    @StateObject private var controller = RunesController()
    
    var body: some View {
        List (
            controller.loadedRunes
//            selection: $controller.selectedRune
        ) { rune in
            NavigationLink(value: rune) {
                Text("\(rune.symbol) - \(rune.name)")
            }
        }
        .navigationTitle("ᚠᚢᚦᚨᚱᚲ")
    }
}

struct RunesListView_Previews: PreviewProvider {
    static var previews: some View {
        RunesListView()
    }
}
