//
//  SettingsRow.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

struct SettingsRow: View {
    var icon: String
    var label: String
    var trailing: String? = nil

    var body: some View {
        HStack {
            Image(systemName: icon)
                // Use systemGreen for icon, adapts well to light/dark modes
                .foregroundColor(Color(.systemGreen))
                .frame(width: 24)

            Text(label)
                // Primary label text uses the default label color,
                // which adapts automatically to light/dark mode
                .foregroundColor(Color.primary)

            Spacer()

            if let trailing = trailing {
                Text(trailing)
                    // Secondary text color that adapts (gray in light, light gray in dark)
                    .foregroundColor(Color.secondary)
            } else {
                Image(systemName: "chevron.right")
                    // Chevron arrow color adapts similarly to secondary text color
                    .foregroundColor(Color.secondary)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        // Background color using system background, adapts to light/dark modes:
        // Light: white or near-white
        // Dark: black or near-black
        .background(Color(UIColor.systemBackground))
        // Optional: rounded corners if used as a card
        //.cornerRadius(8)
    }
}
