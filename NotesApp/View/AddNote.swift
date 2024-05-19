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
    @State private var username: String = ""
    @State  private var email = ""
    @StateObject var viewModel = AddNoteViewModel()
    @EnvironmentObject var authManager: AuthManager
    @State private var showingAlert = false
    var body: some View {
        VStack {
            HStack{
                Text("Username:")
                    .bold()
                VStack{
                    TextField("Enter Username", text: $username)
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
                if username == "" {
                    showingAlert = true
                   
                }else{

                    viewModel.addData(userName: username, value: fullText)
                }
               
                fullText = ""
            }label: {
                Text("Send")
            }
            .padding()
            Button {
                authManager.logOut()
            }label: {
                Text("Log Out")
            }
            .padding()
        }
        .onAppear{
            authManager.readObject()
            authManager.arrNote = viewModel.arrNote
        }
        .alert("Enter Username!", isPresented: $showingAlert) {
                   Button("OK", role: .cancel) { }
               }
    }
 
}

#Preview {
    AddNote()
}
