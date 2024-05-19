//
//  SavedNoteRow.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 20/5/24.
//

import SwiftUI

struct SavedNoteRow: View {
    var noteData : savedNoteModel
    var body: some View {
        VStack {
            Text("Username: \(noteData.userName)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Timestamp: \(String(describing: noteData.timestamp!))")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Note: \(noteData.note)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
    }
}

#Preview {
    SavedNoteRow(noteData: savedNoteModel(userName: "123", timestamp: 123, note: "123"))
}
