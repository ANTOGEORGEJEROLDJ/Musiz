//
//  SettingsView.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var highQualityAudio = false
    @State private var downloadOverWiFi = true

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // MARK: - Account Section
                    SettingsSection(title: "Account") {
                        Group {
                            NavigationLink(destination: ProfileView()) {
                                SettingsRow(icon: "person.crop.circle.fill", label: "Go to Profile")
                            }
                            SettingsRow(icon: "lock.fill", label: "Change Password")
                        }
                    }

                    // MARK: - Playback Section
                    SettingsSection(title: "Playback") {
                        Group{
                            SettingsToggle(icon: "music.note.list", label: "High Quality Audio", isOn: $highQualityAudio)
                            SettingsToggle(icon: "wifi", label: "Download Over Wi-Fi Only", isOn: $downloadOverWiFi)
                        }
                    }

                    // MARK: - Notifications Section
                    SettingsSection(title: "Notifications") {
                        Group{
                            SettingsToggle(icon: "bell.fill", label: "Push Notifications", isOn: $notificationsEnabled)
                        }
                    }

                    // MARK: - About Section
                    SettingsSection(title: "About") {
                        Group{
                            SettingsRow(icon: "info.circle.fill", label: "Version", trailing: "1.0.0")
                            SettingsRow(icon: "doc.text.fill", label: "Terms & Conditions")
                            SettingsRow(icon: "lock.shield.fill", label: "Privacy Policy")
                        }
                    }

                    // MARK: - Logout
                    Button(action: {
                        print("🔒 User logged out")
                    }) {
                        Text("Log Out")
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                }
                .padding()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationTitle("Settings")
            .foregroundColor(.white)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    SettingsView()
}



#Preview {
    SettingsView()
}
