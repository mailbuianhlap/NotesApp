//
//  Notes.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 18/5/24.
//

import SwiftUI
var dataGlobal: [NotesObject] = []
struct Notes: View {
    var body: some View {
        NavigationSplitView {
            List(dataGlobal) { dataGlobal in
                NavigationLink {
//                    LandmarkDetail(landmark: landmark)
                } label: {
//                    LandmarkRow(landmark: landmark)
                    NoteRow()
                }
                
            }
            .navigationTitle("Notes")
        }detail: {
            
        }
    }
}

#Preview {
    Notes()
}
