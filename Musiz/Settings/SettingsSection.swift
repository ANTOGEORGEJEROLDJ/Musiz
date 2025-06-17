//
//  SettingsSection.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

struct SettingsSection<Content: View>: View {
    var title: String
    var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Section Title with green color for emphasis
            Text(title)
                .font(.title2.bold())
                // Use systemGreen so it adapts subtly to light/dark modes
                .foregroundColor(Color(.systemGreen))

            content()
                // Background uses secondarySystemBackground which adapts to light/dark mode:
                // Light mode: light grayish background
                // Dark mode: dark grayish background
                .background(Color(UIColor.secondarySystemBackground))
                // Rounded corners for smooth UI
                .cornerRadius(12)
        }
        // Padding to separate from other sections (optional)
        .padding(.horizontal)
    }
}
