//
//  SavedNoteDetail.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 20/5/24.
//

import SwiftUI

struct SavedNoteDetail: View {
   
    var noteData : savedNoteModel
    @State private var noteString: String = ""
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
                
            }.overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding()
            
            HStack{
                Button{
                    
                }label: {
                    Text("Edit")
                }.padding()
                    .buttonStyle(CustomButtonStyle())
                
                Button{
                    
                }label: {
                    Text("Add to Favorite")
                }  .padding()
                    .buttonStyle(CustomButtonStyle())
                
            }
            
        }.onAppear{
            noteString = noteData.note
        }
    }
}

#Preview {
    SavedNoteDetail(noteData: savedNoteModel(userName: "123", timestamp: 123, note: "123"))
}
