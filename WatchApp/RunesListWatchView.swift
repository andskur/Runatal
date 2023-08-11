//
//  ContentView.swift
//  RunatalWatchOs Watch App
//
//  Created by Andrey Skurlatov on 1.8.23..
//

import SwiftUI

struct RunesListWatchView: View {
    @StateObject private var controller = RunesController()
    @State private var isSettingsActive = false
    
    var settings: some View {
        Group {
            Form {
                Picker("Translation", selection: $controller.translation) {
                    ForEach(TranslationLanguage.allCases, id: \.self) { translation in
                        Text(translation.rawValue.capitalized).tag(translation)
                    }
                }
            }
            .padding()
            
         }
        .opacity(0.8)
        .padding(10)
    }
    
    var body: some View {
        ScrollViewReader {value in
            ScrollView {
                Button(action: {isSettingsActive.toggle() }, label: {
                    Text("Settings")
                    Image(systemName: "gear")
                })
                .fullScreenCover(isPresented: $isSettingsActive) {
                    settings
                }
                
                Spacer()
                Spacer()
                
                LazyVStack(alignment: .leading) { // Use LazyVStack for improved performance
                    ForEach(controller.loadedRunes) { rune in
                        Group {
                            Text(rune.symbol).font(.system(size: 90)).fontWeight(.bold)
                            Divider()
                            Group {
                                Text(rune.name).font(.system(size: 30))
//                                Text(rune.Meaning.generate(language: controller.translation).capitalized)
                            }
                            Divider()
                            Text("Sound: \(rune.sound)")
                            Divider()
                        }
                        .padding()
                    }
                    .navigationTitle("Words")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RunesListWatchView()
    }
}
