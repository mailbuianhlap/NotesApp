//
//  SavedNotes.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 18/5/24.
//

import SwiftUI

struct SavedNotes: View {
    @StateObject var viewModel = MyNotesViewModel()
    @EnvironmentObject var authManager : AuthManager
    var body: some View {
        VStack {
            if authManager.noteObject != nil {
                NavigationSplitView {
                    List(authManager.noteObject!.savedNote, id: \.timestamp) { dataOfNote in
                        NavigationLink {
                            SavedNoteDetail( noteData: dataOfNote)
                        } label: {
                            SavedNoteRow(noteData: dataOfNote)
                        }
                    }
                    .navigationTitle("My Notes")
                }detail: {
                }
            }else{
                Text("Dont have any notes!")
                    .padding()
                    .background(
                        Color.gray
                    )
            }
        }
        .onAppear{
//            viewModel.fetchData()
        }
    }
}

#Preview {
    SavedNotes()
}
