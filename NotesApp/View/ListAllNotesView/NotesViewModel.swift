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
    @Published
    var noteObject: AllNotesModel? = nil
    func fetchData() {
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
