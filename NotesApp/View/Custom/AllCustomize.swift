//
//  AllCustom.swift
//  NotesApp
//
//  Created by Bui Anh Lap on 19/5/24.
//

import Foundation
import SwiftUI
struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .shadow(color: .gray, radius: 5, x: 0, y: 5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.6, blendDuration: 0.2), value: configuration.isPressed)
            .bold()
            .foregroundColor(.green)
    }
}
