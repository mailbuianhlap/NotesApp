//
//  Login.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 18/5/24.
//

import SwiftUI
import FirebaseAuth
struct Login: View {
    
    var noteObject: NotesObjectModel? = nil
    @State  private var email = ""
    @State  private var password = ""
//    @State  private var userIsLoggedIn = false
    @EnvironmentObject var authManager: AuthManager
    var body: some View {
        if authManager.isSignedIn {
            MainView()
        } else {
            content
        }
    }
    var content : some View {
        ZStack {
            Color.secondary
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.pink, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 500, height: 1000)
            VStack(spacing: 20) {
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                
                Rectangle()
                    .frame(width: 350, height: 1)
                
                SecureField("Password", text: $password)
                    .foregroundColor(.blue)
                    .textFieldStyle(.plain)
                
                Rectangle()
                    .frame(width: 350, height: 1)
                
                Button {
                    authManager.login(email: email, password: password)
                } label: {
                    Text("Sign in")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(.pink)
                        .foregroundColor(.white)
                }.offset(x:0, y: +50)
                
            }
            .frame(width: 350)
            .onAppear {
                //                Auth.auth().addStateDidChangeListener({
                //                    auth, user in
                //                    if user != nil {
                //                        userIsLoggedIn.toggle()
                //                    }
                //                })
                //                authManager.readObject()
            }
        }.ignoresSafeArea()
    }
    
}

#Preview {
    Login()
}
