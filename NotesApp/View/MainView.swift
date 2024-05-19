//
//  MainView.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 18/5/24.
//

import SwiftUI

struct MainView: View {
    @State var selection = 0
    @EnvironmentObject var authManager: AuthManager
    var body: some View {
        TabView(selection: $selection) {
            AddNote()
                .tabItem {
                    Label("Add", systemImage: "pencil.line")
                }.tag(0)
            Notes()
                .tabItem {
                    Label("Notes", systemImage: "pencil.circle")
                }.tag(1)
            SavedNotes()
                .tabItem {
                    Label("Saved Note", systemImage: "tray.and.arrow.down.fill")
                }.tag(2)
        }.onAppear{
            authManager.fetchData()
        }
        
    }
}

#Preview {
    MainView()
}
