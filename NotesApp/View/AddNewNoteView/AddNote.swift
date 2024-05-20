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
    @State private var showingAlert = false
    @State private var checkSendDataSuccess = false
    @StateObject var viewModel = AddNoteViewModel()
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        VStack {
            HStack{
                Text("Username:")
                    .bold()
                VStack{
                    TextField("Enter Username", text: $username)
                        .textFieldStyle(.roundedBorder)
                        .foregroundColor(.black)
                        .frame(width: 230)
                        
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
                if username == "" || fullText == "" {
                    showingAlert = true
                }else{
                    viewModel.addData(userName: username, value: fullText)
                    fullText = ""
                    checkSendDataSuccess = true
                }
               
            }label: {
                Text("Send")
                
            }.padding()
                .background(.black)
                .cornerRadius(10)
                .shadow(color: .gray,radius: 1, x:0, y:5)
            
            Button {
                authManager.logOut()
            }label: {
                Text("Log Out")
            }.padding()
                .background(.black)
                .cornerRadius(10)
                .shadow(color: .gray,radius: 1, x:0, y:5)
                .padding()
        }
        .onAppear{
            authManager.fetchData()
            username = authManager.noteObject?.userName ?? ""
        }
        .alert("Enter Username and note!", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }.alert("Success create note!", isPresented: $checkSendDataSuccess) {
            Button("OK", role: .cancel) { }
        }
    }
}

#Preview {
    AddNote()
}
