//
//  Models.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 19/5/24.
//

import Foundation


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
