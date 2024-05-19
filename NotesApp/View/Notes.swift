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
                    .navigationTitle("Notes")
                }detail: {
                    
                }
             
            }else{
                Text("Nothing to show here!")
                    .padding()
                    .background(
                        Color.gray
                    )
            }
        }
        .onAppear{
            viewModel.readObject()
        }
    }
}

#Preview {
    Notes()
}
