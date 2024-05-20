//
//  Notes.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 18/5/24.
//

import SwiftUI
struct Notes: View {
    @EnvironmentObject var authManager : AuthManager
    var body: some View {
        VStack {
            if authManager.allNoteObject != nil {
                NavigationSplitView {
                    List(authManager.allNoteObject!.notes, id: \.timestamp) { dataOfNote in
                        NavigationLink {
                            NoteDetail(noteData: dataOfNote)
                        } label: {
                            
                            NoteRow(noteData: dataOfNote)
                        }
                    }
                    .navigationTitle("All Notes")
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
    }
}

#Preview {
    Notes()
}
