//
//  MainView.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 18/5/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            AddNote()
                .tabItem {
                    Label("Add", systemImage: "pencil.line")
                }
            Notes()
            //                .badge(2)
                .tabItem {
                    Label("Notes", systemImage: "pencil.circle")
                }
            SavedNotes()
                .tabItem {
                    Label("Saved Note", systemImage: "tray.and.arrow.down.fill")
                }
        }
    }
}

#Preview {
    MainView()
}
