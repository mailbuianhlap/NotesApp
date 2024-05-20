//
//  AddNoteViewModel.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 18/5/24.
//

import Foundation
import SwiftUI
import FirebaseDatabase
import FirebaseAuth

class AddNoteViewModel : ObservableObject {
    var ref = Database.database().reference()
    @StateObject var authManager = AuthManager()
    func addData(userName: String,value: String) {
        // timestamp = uid for note object
        let timestamp = Int(NSDate.timeIntervalSinceReferenceDate*1000)
        writeNotesObjectModel(userName: userName, value: value, timestamp: timestamp)
        writeAllNotesModel(userName: userName, value: value, timestamp: timestamp)
    }
    func writeNotesObjectModel(userName: String,value: String, timestamp: Int) {
        var dataNotesObject = NotesObjectModel()
        dataNotesObject.userName = userName
        // check if noteObject exist or not to push new data
        // Helper is a singeton class to store data about array of saved note and note object
        // created when login success check .onappear function
        if Helper.shared.noteObject != nil {
            Helper.shared.arrNote.append(NoteModel(timestamp: timestamp, note: value))
            dataNotesObject.notes = Helper.shared.arrNote
            if Helper.shared.noteObject?.savedNote != nil {
            }else{
                Helper.shared.arrSavedNote.append(savedNoteModel(userName: userName, timestamp: timestamp, note: value))
            }
            dataNotesObject.savedNote = Helper.shared.arrSavedNote
        }else{
            dataNotesObject.notes.append(NoteModel(timestamp: timestamp, note: value))
            dataNotesObject.savedNote.append(savedNoteModel(userName: userName, timestamp: timestamp, note: value))
        }
        // push data to User.uid
        ref.child("\( String(describing: Auth.auth().currentUser!.uid))").setValue(dataNotesObject.toDictionary)
    }
    func writeAllNotesModel(userName: String,value: String, timestamp: Int) {
        var dataAllNotesObject = AllNotesModel()
        Helper.shared.arrAllNote.append(NotePublicModel(userName: userName, timestamp: timestamp, note: value))
        dataAllNotesObject.notes =   Helper.shared.arrAllNote
        // push data to all notes object in database
        ref.child("AllNotes/allNotes").setValue(dataAllNotesObject.toDictionary)
        // restore new data from database for singeton class
        authManager.fetchData()
    }
}
extension Encodable {
    var toDictionary : [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {return nil}
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
    }
    
}
