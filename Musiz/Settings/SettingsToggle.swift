//
//  SettingsToggle.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

struct SettingsToggle: View {
    var icon: String
    var label: String
    @Binding var isOn: Bool

    var body: some View {
        Toggle(isOn: $isOn) {
            HStack {
                Image(systemName: icon)
                    // Use systemGreen to auto-adapt in light/dark mode
                    .foregroundColor(Color(.systemGreen))
                    .frame(width: 24)
                Text(label)
                    // Use primary color for text to automatically adapt to mode
                    .foregroundColor(Color.primary)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        // Background color that adapts based on system appearance:
        // Light mode: light gray background
        // Dark mode: dark gray background
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12) // Rounded corners for neat UI
    }
}
