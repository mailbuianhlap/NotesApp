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
    func saveNoteToSavedNotes(username: String, timestamp: Int, note: String ) {
        
        let dataNotesObject = NotesObjectModel()
        dataNotesObject.userName = username
        
        dataNotesObject.notes = Helper.shared.arrNote
      
            Helper.shared.arrSavedNote.append(savedNoteModel(userName: username, timestamp: timestamp, note: note))
        
        dataNotesObject.savedNote = Helper.shared.arrSavedNote
        
        // push data to User.uid
        ref.child("\( String(describing: Auth.auth().currentUser!.uid))").setValue(dataNotesObject.toDictionary)
    }
}
