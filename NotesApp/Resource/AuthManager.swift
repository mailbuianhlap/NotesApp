//
//  AuthManager.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 18/5/24.
//

import Foundation
import FirebaseAuth

class AuthManager: ObservableObject {
    @Published var isSignedIn: Bool = false
    
    init() {
        self.isSignedIn = Auth.auth().currentUser != nil
        Auth.auth().addStateDidChangeListener { (_, user) in
            self.isSignedIn = user != nil
        }
    }
}
