//
//  NoteDetail.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 18/5/24.
//

import SwiftUI

struct NoteDetail: View {
    @State private var addToFavoriteFlag = false
    @State private var checkAlreadydAdd = false
    @State private var noteString: String = ""
    var noteData : NotePublicModel
    @StateObject var viewModel = NotesViewModel()
    var body: some View {
        VStack {
            Text("Username: \(noteData.userName)")
            VStack {
                TextEditor(text: $noteString)
                    .frame(height:400, alignment: .center)
                    .lineSpacing(10)
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
                    .padding()
                    .disabled(true)
            }.overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding()
            
            HStack{
                Button{
                    if Helper.shared.arrSavedNote.contains(where: {
                        result in
                        if noteData.timestamp == result.timestamp{
                            return true
                        }else{
                            return false
                        }
                    }) {
                        checkAlreadydAdd = true
                    }else{
                        
                        viewModel.saveNoteToSavedNotes(username: noteData.userName, timestamp: noteData.timestamp!, note: noteData.note)
                        addToFavoriteFlag = true
                    }
                }label: {
                    Text("Add to Favorite")
                }
                .padding()
                .buttonStyle(CustomButtonStyle())
            }
        }.onAppear{
            _noteString.wrappedValue = noteData.note
        }
        .alert("Add to favorite list success!", isPresented: $addToFavoriteFlag) {
            Button("OK", role: .cancel) { }
        }
        .alert("Already add this note to favorite list!", isPresented: $checkAlreadydAdd) {
            Button("OK", role: .cancel) { }
        }

        
    }
}

#Preview {
    NoteDetail(noteData: NotePublicModel(userName: "Test", timestamp: 123, note: "Test"))
}
