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
    //    @StateObject var authManager = AuthManager()
    func addData(userName: String,value: String) {
        let timestamp = Int(NSDate.timeIntervalSinceReferenceDate*1000)
        var dataNotesObject = NotesObjectModel()
        dataNotesObject.userName = userName
        if Helper.shared.noteObject != nil {
            Helper.shared.arrNote.append(NoteModel(timestamp: timestamp, note: value))
            dataNotesObject.notes = Helper.shared.arrNote
//            Helper.shared.arrSavedNote.append(savedNoteModel(userName: userName, timestamp: timestamp, note: value))
            dataNotesObject.savedNote = Helper.shared.arrSavedNote
        }else{
            dataNotesObject.notes.append(NoteModel(timestamp: timestamp, note: value))
            dataNotesObject.savedNote.append(savedNoteModel(userName: userName, timestamp: timestamp, note: value))
        }
   
        let data = try? JSONEncoder().encode(dataNotesObject)
        let ObjData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : Any]
        ref.child("\( String(describing: Auth.auth().currentUser!.uid))").setValue(ObjData)
        
        
    }
    func dataToNotesObjectModel(dataObj: NotesObjectModel) -> [String : Any]  {
        let data = try? JSONEncoder().encode(dataObj)
        let ObjData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : Any]
        return ObjData!
    }
    //    func pushObject(userName: String,value: String){
    //        let timestamp = Int(NSDate.timeIntervalSinceReferenceDate*1000)
    //
    //        var dataNotesObject = NotesObjectModel()
    //
    //        dataNotesObject.userName = userName
    //
    //        self.authManager.arrNote.append(NoteModel(timestamp: timestamp, note: value))
    //        dataNotesObject.notes = self.authManager.arrNote
    //        self.authManager.arrSavedNote.append(savedNoteModel(userName: userName, timestamp: timestamp, note: value))
    //        dataNotesObject.savedNote = self.authManager.arrSavedNote
    //
    //        let data = try? JSONEncoder().encode(dataNotesObject)
    //        let ObjData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : Any]
    ////        let cat = dataToNotesObjectModel(dataObj: dataNotesObject)
    //
    //        self.authManager.ref.child("\(Auth.auth().currentUser!.uid)").setValue(ObjData)
    //
    //        var dataAllNotesObject = AllNotesModel()
    //
    //
    //        self.authManager.arrAllNote.append(NotePublicModel(userName: userName, timestamp: timestamp, note: value))
    //        dataAllNotesObject.notes =  self.authManager.arrAllNote
    //
    //        let data2 = try? JSONEncoder().encode(dataAllNotesObject)
    //        let ObjData2 = try? JSONSerialization.jsonObject(with: data2!, options: .allowFragments) as? [String : Any]
    //        self.authManager.ref.child("AllNotes/allNotes").setValue(ObjData2)
    //
    //
    //
    //    }
}
struct AllNotesModelWrapped : Codable {
    var allNotes : AllNotesModel
}
struct AllNotesModel: Codable {
    var notes : [NotePublicModel] = []
}
class NotesObjectModel: Codable {
    var userName : String = ""
    var notes : [NoteModel] = []
    var savedNote: [savedNoteModel] = []
}
struct NoteModel : Codable {
    var timestamp: Int? = nil
    var note : String = ""
}
struct savedNoteModel : Codable {
    var userName : String = ""
    var timestamp: Int? = nil
    var note : String = ""
}
struct NotePublicModel : Codable {
    var userName : String = ""
    var timestamp: Int? = nil
    var note : String = ""
}
