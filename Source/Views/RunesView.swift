//
//  ContentView.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 30.7.23..
//

import SwiftUI


struct ContentView: View {
    @StateObject private var controller = RunesController()
    @State private var isSettingsActive = false
    @State private var selectedRune: Rune?
    
    var settings: some View {
        Group {
            #if os(iOS)
            HStack(spacing: 4) {
                Spacer()
                Button(action: {isSettingsActive.toggle() }, label: {
                    Image(systemName: "xmark.circle")
                })
            }
            .padding(.trailing)
            #endif
            
            Form {
                Picker("Translation", selection: $controller.translation) {
                    ForEach(TranslationLanguage.allCases, id: \.self) { translation in
                        Text(translation.rawValue.capitalized).tag(translation)
                    }
                }
            }
            .padding()
         }
         .padding()
    }
        
    var body: some View {
        #if os(iOS)
        Button(action: {isSettingsActive.toggle() }, label: {
            Spacer()
            Image(systemName: "gear")
                
        })
        .sheet(isPresented: $isSettingsActive) {
            settings
        }
        .padding(.trailing)
        #endif
        
        NavigationSplitView {
            List (
                controller.loadedRunes,
                selection: $selectedRune
            ) { rune in
                NavigationLink(value: rune) {
                    Text("\(rune.symbol) - \(rune.name)")
                }
            }
            .navigationTitle("ᚠᚢᚦᚨᚱᚲ")
        } detail: {
            ZStack {
                if let rune = selectedRune {
                    RuneDetailView(rune: rune, translationLanguage: controller.translation)
                } else {
                    Text("Nothing Selected")
                }
            }
        }
        .onAppear {
            #if os(macOS)
            selectedRune = controller.loadedRunes[0]
            #else
            let isiPhone =  UIDevice.current.userInterfaceIdiom.rawValue == 0 ? true : false
            
            if !isiPhone {
                selectedRuneNew = controller.loadedRunes[0]
            }
            #endif
        }
        #if os(macOS)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: { isSettingsActive.toggle() }, label: {
                    Image(systemName: "gear")
                })
                .sheet(isPresented: $isSettingsActive) {
                    HStack(spacing: 4) {
                        Spacer()
                        Button(action: {isSettingsActive.toggle() }, label: {
                            Image(systemName: "xmark.circle")
                        })
                    }
                    settings
                }
            }
        }
        #endif
    }
}
