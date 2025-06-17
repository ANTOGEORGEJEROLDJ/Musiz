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

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.green)
                .frame(width: 30)

            if placeholder.lowercased().contains("password") {
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    SecureField("", text: $text)
                        .foregroundColor(.white)
                }
            } else {
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    TextField("", text: $text)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.green.opacity(0.3), lineWidth: 1)
        )
    }
}
