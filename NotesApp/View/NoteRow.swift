//
//  NoteRow.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 18/5/24.
//

import SwiftUI

struct NoteRow: View {
    @EnvironmentObject var authManager: AuthManager
//    var noteData : NotePublicModel
    var noteData : NotePublicModel
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
    Group{
        NoteRow(noteData: NotePublicModel(userName: "321", timestamp:21321312, note: "123"))
    }
}
