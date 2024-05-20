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
    @State private var checkNilMailAndPass = false
    @State private var checkSignUpFail = false
    @State private var checkSignUpSuccess = false
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
                    if email == "" || password == "" {
                        checkNilMailAndPass = true
                    }else{
                        authManager.login(email: email, password: password)
                    }
                } label: {
                    Text("Sign in")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(.pink)
                        .foregroundColor(.white)
                }.offset(x:0, y: +50)
            }
            .frame(width: 350)
        }.ignoresSafeArea()
            .alert("Please enter email and password!", isPresented: $checkNilMailAndPass) {
                Button("OK", role: .cancel) { }
            }
    }
}

#Preview {
    Login()
}
