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
    var arrNote = Array<NoteModel>()
    var ref = Database.database().reference()
    @StateObject var authManager = AuthManager()
    func addData(userName: String,value: String) {
        let timestamp = Int(NSDate.timeIntervalSinceReferenceDate*1000)
        var dataNotesObject = NotesObjectModel()
        dataNotesObject.userName = userName
        if Helper.shared.noteObject != nil {
            Helper.shared.arrNote.append(NoteModel(timestamp: timestamp, note: value))
            dataNotesObject.notes = Helper.shared.arrNote
            if Helper.shared.noteObject?.savedNote != nil {
//                dataNotesObject.savedNote = Helper.shared.arrSavedNote
            }else{
                Helper.shared.arrSavedNote.append(savedNoteModel(userName: userName, timestamp: timestamp, note: value))
//                dataNotesObject.savedNote = Helper.shared.arrSavedNote
            }
            //            Helper.shared.arrSavedNote.append(savedNoteModel(userName: userName, timestamp: timestamp, note: value))
            dataNotesObject.savedNote = Helper.shared.arrSavedNote
        }else{
            dataNotesObject.notes.append(NoteModel(timestamp: timestamp, note: value))
            dataNotesObject.savedNote.append(savedNoteModel(userName: userName, timestamp: timestamp, note: value))
        }
        
        let data = try? JSONEncoder().encode(dataNotesObject)
        let ObjData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : Any]
        ref.child("\( String(describing: Auth.auth().currentUser!.uid))").setValue(ObjData)
        
        var dataAllNotesObject = AllNotesModel()
        
        
        Helper.shared.arrAllNote.append(NotePublicModel(userName: userName, timestamp: timestamp, note: value))
        dataAllNotesObject.notes =   Helper.shared.arrAllNote
        
        let data2 = try? JSONEncoder().encode(dataAllNotesObject)
        let ObjData2 = try? JSONSerialization.jsonObject(with: data2!, options: .allowFragments) as? [String : Any]
        ref.child("AllNotes/allNotes").setValue(ObjData2)
        authManager.fetchData()
        
    }
    func dataToNotesObjectModel(dataObj: NotesObjectModel) -> [String : Any]  {
        let data = try? JSONEncoder().encode(dataObj)
        let ObjData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : Any]
        return ObjData!
    }
    
}
