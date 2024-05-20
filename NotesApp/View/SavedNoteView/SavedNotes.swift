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
                List(authManager.noteObject!.savedNote, id: \.timestamp) { dataOfNote in
                    SavedNoteRow(noteData: dataOfNote)
                }
                .navigationTitle("My Notes")
                
            }else{
                Text("Dont have any notes!")
                    .padding()
                    .background(
                        Color.gray
                    )
            }
        }
        
    }
}

#Preview {
    SavedNotes()
}
