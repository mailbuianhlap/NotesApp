//
//  AuthManager.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 18/5/24.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseDatabase
import FirebaseDatabaseSwift
class Helper {
    static let shared = Helper()
    var arrNote = Array<NoteModel>()
    var arrSavedNote = Array<savedNoteModel>()
    var arrAllNote = Array<NotePublicModel>()
    var noteObject: NotesObjectModel? = nil
    var allNoteObject: AllNotesModel? = nil
    
    func releaseData() {
        arrNote.removeAll()
        arrSavedNote.removeAll()
        arrAllNote.removeAll()
        noteObject = nil
        allNoteObject = nil
    }
}
class AuthManager: ObservableObject {
    @Published var checkErrorSignUp: Bool = false
    var ref = Database.database().reference()
    @Published var noteObject: NotesObjectModel? = nil
    @Published var allNoteObject: AllNotesModel? = nil
    @Published var isSignedIn: Bool = false
    init() {
        self.isSignedIn = Auth.auth().currentUser != nil
        Auth.auth().addStateDidChangeListener { [self] (_, user) in
            isSignedIn = user != nil
        }
    }
    func fetchData() {
        fetchNoteObject()
        fetchAllNoteObject()
    }
    func fetchNoteObject() {
        ref.child("\(Auth.auth().currentUser!.uid)").observe( .value) { [self] snapshot in
            do {
                self.noteObject = try snapshot.data(as: NotesObjectModel.self)
                Helper.shared.arrNote = self.noteObject!.notes
                Helper.shared.arrSavedNote = self.noteObject!.savedNote
                Helper.shared.noteObject = self.noteObject!
            } catch {
                print("Cannot convert to NotesObjectModel at fetchNoteObject function")
            }
        }
    }
    func fetchAllNoteObject() {
        ref.child("AllNotes/allNotes").observe(.value) {
            snapshot in
            do {
                self.allNoteObject = try snapshot.data(as: AllNotesModel.self)
                Helper.shared.arrAllNote = self.allNoteObject!.notes
            } catch {
                print("Cannot convert to NotesObjectModel at fetchAllNoteObject function")
            }
        }
    }
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [self] (authResult, error) in
                if let error = error {
                    checkErrorSignUp = true
                    print("Error signing up: \(error.localizedDescription)")
                }
                
            }
        }
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password, completion: {
            result, error in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                
            }
        })
    }
    func logOut() {
        do {
            try Auth.auth().signOut()
            //release memory of all arr
            Helper.shared.releaseData()
            self.noteObject = nil
            self.allNoteObject = nil
        } catch let err as NSError {
            print("Error logout: \(err.localizedDescription)")
        }
    }
}
