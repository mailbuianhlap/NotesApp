//
//  Notes.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 18/5/24.
//

import SwiftUI
struct Notes: View {
    @StateObject var viewModel = NotesViewModel()
    @EnvironmentObject var authManager : AuthManager
    var body: some View {
        VStack {
            if authManager.allNoteObject != nil {
                NavigationSplitView {
                    List(authManager.allNoteObject!.notes, id: \.timestamp) { dataOfNote in
                        NavigationLink {
                            NoteDetail()
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
        .onAppear{
//            viewModel.fetchData()
        }
    }
}

#Preview {
    Notes()
}
