//
//  AddNoteViewModel.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 18/5/24.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
class AddNoteViewModel : ObservableObject {
    private let ref = Database.database().reference()
    let user = Auth.auth().currentUser
    
    func pushNewValue(value: String) {
        ref.setValue(value)
    }
    
    func pushObject(userName: String,value: String){
        let timeStamp = Int(NSDate.timeIntervalSinceReferenceDate*1000)
        var arr = Array<Any>()
        
        var obj = Note(timestamp: Date.init(timeIntervalSince1970: .pi))
        
        obj.note = value
        let data = try? JSONEncoder().encode(obj)
        let ObjData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : Any]
        var obj2 = NotesObject()
        obj2.userName = userName
        obj2.notes = value
        let data2 = try? JSONEncoder().encode(obj2)
        let ObjData2 = try? JSONSerialization.jsonObject(with: data2!, options: .allowFragments) as? [String : Any]
        
        arr.append(ObjData)
        self.ref.child("AllNotes").child(user!.uid).child("Username").setValue(userName)
        self.ref.child("AllNotes").child(user!.uid).child("notes").child(String(timeStamp)).setValue(ObjData2)
        
        
        self.ref.child("AllNotes").child(user!.uid).child("SavedNotes").setValue(ObjData2)
        
    }
}
class NotesObject: Encodable, Identifiable {
    var userName : String = ""
    var notes : String = ""
}
struct Note : Encodable {
    var timestamp: Date? = nil
    var note : String = ""
}
