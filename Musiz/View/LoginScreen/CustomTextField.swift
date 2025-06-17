//
//  CustomTextField.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//
import SwiftUI

struct CustomTextField: View {
    var icon: String
    var placeholder: String
    @Binding var text: String

    // Use dynamic colors that automatically adapt to light/dark mode
    var body: some View {
        HStack {
            // Icon (green in both modes)
            Image(systemName: icon)
                .foregroundColor(.green)
                .frame(width: 30)

            if placeholder.lowercased().contains("password") {
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        // Placeholder color adapts to light/dark mode
                        Text(placeholder)
                            .foregroundColor(Color.primary.opacity(0.5))
                    }
                    SecureField("", text: $text)
                        .foregroundColor(Color.primary) // adapts based on mode
                }
            } else {
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(Color.primary.opacity(0.5))
                    }
                    TextField("", text: $text)
                        .foregroundColor(Color.primary)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
            }
        }
        .padding()
        // Background adapts to system theme using systemBackground
        .background(Color(.systemBackground).opacity(0.05))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.green.opacity(0.3), lineWidth: 1)
        )
    }
}
