//
//  MyNotes.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 19/5/24.
//

import SwiftUI

struct MyNotes: View {
    
    @StateObject var viewModel = MyNotesViewModel()
    @EnvironmentObject var authManager : AuthManager
    var body: some View {
        VStack {
            if authManager.noteObject != nil {
                NavigationSplitView {
                    List(authManager.noteObject!.notes, id: \.timestamp) { dataOfNote in
                        NavigationLink {
                            MyNoteDetail(userName: authManager.noteObject!.userName, noteData: dataOfNote)
                        } label: {
                            MyNoteRow(userName: authManager.noteObject!.userName, noteData: dataOfNote)
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
    MyNotes()
}
