//
//  NoteRow.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 18/5/24.
//

import SwiftUI

struct NoteRow: View {
    var body: some View {
        
        VStack {
            Text("Username: ConMeo")
                .frame(maxWidth: .infinity, alignment: .leadingFirstTextBaseline)
            Text("gbnergbhjerbgebgr iengbuorengorehng oregoirgoei")
                .offset(CGSize(width: 10.0, height: 10.0))
            Spacer()
        }
    }
}

#Preview {
    NoteRow()
}
