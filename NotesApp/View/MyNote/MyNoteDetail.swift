//
//  MyNoteDetail.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 19/5/24.
//

import SwiftUI

struct MyNoteDetail: View {
    @State private var addToFavoriteFlag = false
    @State private var checkValidAdd = false
    @State private var checkEditSuccess = false
    @State private var checkTextNil = false
    @StateObject var viewModel = MyNotesViewModel()
    var userName : String
    var noteData : NoteModel
    @State private var noteString: String = ""
    var body: some View {
        VStack {
            Text("Username: \(userName)")
            VStack {
                TextEditor(text: $noteString)
                    .frame(height:400, alignment: .center)
                    .lineSpacing(10)
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
                    .padding()
                
            }.overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding()
            
            HStack{
                Button{
                    if _noteString.wrappedValue == "" {
                        checkTextNil = true
                    }else{
                        if let i = Helper.shared.arrNote.firstIndex(where: { $0.timestamp == noteData.timestamp }) {
                            Helper.shared.arrNote[i].note = _noteString.wrappedValue
                           }
                        if let i = Helper.shared.arrSavedNote.firstIndex(where: { $0.timestamp == noteData.timestamp }) {
                            Helper.shared.arrSavedNote[i].note = _noteString.wrappedValue
                           }
                        if let i = Helper.shared.arrAllNote.firstIndex(where: { $0.timestamp == noteData.timestamp }) {
                            Helper.shared.arrAllNote[i].note = _noteString.wrappedValue
                           }
                        viewModel.editNote(username: userName)
                        checkEditSuccess = true
                    }
                
                }label: {
                    Text("Edit")
                }.padding()
                    .buttonStyle(CustomButtonStyle())
                
                Button{
                    if Helper.shared.arrSavedNote.contains(where: {
                        result in
                        if noteData.timestamp == result.timestamp{
                            return true
                        }else{
                            return false
                        }
                    }) {
                        checkValidAdd = true
                    }else{
                        viewModel.saveNoteToSavedNotes(username: userName, timestamp: noteData.timestamp!, note: noteData.note)
                        addToFavoriteFlag = true
                    }
                    
                }label: {
                    Text("Add to Favorite")
                }  .padding()
                    .buttonStyle(CustomButtonStyle())
            }
            
        }.onAppear{
            _noteString.wrappedValue = noteData.note
        }
        .alert("Add to favorite list success!", isPresented: $addToFavoriteFlag) {
            Button("OK", role: .cancel) { }
        }
        .alert("Already add this note to favorite list!", isPresented: $checkValidAdd) {
            Button("OK", role: .cancel) { }
        }
        .alert("Edit Success", isPresented: $checkEditSuccess) {
            Button("OK", role: .cancel) { }
        }
        .alert("Note must have value!", isPresented: $checkTextNil) {
            Button("OK", role: .cancel) { }
        }
        
    }
}

#Preview {
    MyNoteDetail(userName: "User", noteData: NoteModel(timestamp: 123, note: "note"))
}

