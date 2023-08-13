//
//  ContentView.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 9.8.23..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RunesView()
                .badge(2)
                .tabItem {
                    Label("Runes", systemImage: "tray.and.arrow.down.fill")
                }
            Text("JOPA")
                .tabItem {
                    Label("Sent", systemImage: "tray.and.arrow.up.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
