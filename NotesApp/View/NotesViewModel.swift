//
//  NotesViewModel.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 18/5/24.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift
import FirebaseAuth
class NotesViewModel : ObservableObject {
    
    
    var ref = Database.database().reference()
    let user = Auth.auth().currentUser
    @Published
    var noteObject: AllNotesModel? = nil
    @Published
    var userName: String? = nil
//    func readValue() {
//        ref.child("AllNotes/\(user!.uid)/userName").observeSingleEvent(of: .value, with: {
//            snapshot in
//            self.userName = snapshot.value as? String
//        })
//    }
    func readObject() {
        ref.child("AllNotes/allNotes").observe(.value, with: {
            snapshot in
            do {
                self.noteObject = try snapshot.data(as: AllNotesModel.self)
            } catch {
                print("Cannot convert to NotesObjectModel NotesViewModel")
            }
        })
    }
}
