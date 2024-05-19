//
//  MyNotesViewModel.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 19/5/24.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseDatabaseSwift

class MyNotesViewModel :ObservableObject {
    var ref = Database.database().reference()
//    @Published
//    var noteObject: NotesObjectModel? = nil
    func saveNoteToSavedNotes(username: String, timestamp: Int, note: String ) {
        
        let dataNotesObject = NotesObjectModel()
        dataNotesObject.userName = username
        
        dataNotesObject.notes = Helper.shared.arrNote
      
            Helper.shared.arrSavedNote.append(savedNoteModel(userName: username, timestamp: timestamp, note: note))
        
        dataNotesObject.savedNote = Helper.shared.arrSavedNote
        
        // push data to User.uid
        ref.child("\( String(describing: Auth.auth().currentUser!.uid))").setValue(dataNotesObject.toDictionary)
    }
    func editNote(username: String) {
        
        let dataNotesObject = NotesObjectModel()
        dataNotesObject.userName = username
        dataNotesObject.notes = Helper.shared.arrNote
        dataNotesObject.savedNote = Helper.shared.arrSavedNote
        // push data to User.uid
        ref.child("\( String(describing: Auth.auth().currentUser!.uid))").setValue(dataNotesObject.toDictionary)
        
        
        var dataAllNotesObject = AllNotesModel()
        dataAllNotesObject.notes =   Helper.shared.arrAllNote
        // push data to all notes object in database
        ref.child("AllNotes/allNotes").setValue(dataAllNotesObject.toDictionary)
        // restore new data from database for singeton class
//        authManager.fetchData()
    }
}
