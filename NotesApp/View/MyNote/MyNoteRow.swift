//
//  MyNoteRow.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 19/5/24.
//

import SwiftUI

struct MyNoteRow: View {
    var userName : String
    var noteData : NoteModel
    var body: some View {
        VStack {
            Text("Username: \(userName)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Note: \(noteData.note)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
    }
}

#Preview {
    MyNoteRow( userName: "Cat", noteData: NoteModel(timestamp: 23432432, note: "321321321"))
}
