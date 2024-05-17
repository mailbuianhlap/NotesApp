//
//  AddNote.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 18/5/24.
//

import SwiftUI
import FirebaseAuth
struct AddNote: View {
    @State private var fullText: String = ""
    @State private var username: String = "User1"
    @State  private var email = ""
    @StateObject var viewModel = AddNoteViewModel()
    var body: some View {
        VStack {
            HStack{
                Text("Username:")
                    .bold()
                VStack{
                    TextField("", text: $username)
                        .textFieldStyle(.plain)
                        .foregroundColor(.black)
                    Divider()
                        .frame(height: 1)
                        .background(Color.black)
                }
            }.offset(x:20, y:0)
            
            Text("Write a note:")
            
            VStack {
                TextEditor(text: $fullText)
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
            
            
            
            
            Button {
                viewModel.pushObject(userName: username, value: fullText)
                fullText = ""
            }label: {
                Text("Send")
            }
            .padding()
            Button {
               LogOut()
            }label: {
                Text("Log Out")
            }
            .padding()
        }
    }
    func LogOut() {
        do {
            try Auth.auth().signOut()
        } catch let err as NSError {
            print("Error logout: \(err.localizedDescription)")
        }
    }
}

#Preview {
    AddNote()
}
