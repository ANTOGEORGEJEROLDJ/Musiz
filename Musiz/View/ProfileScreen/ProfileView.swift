//
//  ProfileView.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var user: User?
    @State private var showingImagePicker = false
    @State private var profileImage: UIImage?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Image Button to open ImagePicker
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        if let image = profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                // Green stroke border adapting to dark/light mode
                                .overlay(Circle().stroke(Color.green, lineWidth: 2))
                        } else {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.top, 30)
                    .sheet(isPresented: $showingImagePicker, onDismiss: saveProfileImage) {
                        ImagePicker(image: $profileImage)
                    }

                    // Username with adaptive primary color
                    Text(user?.username ?? "No Name")
                        .font(.title2).bold()
                        .foregroundColor(.primary)

                    // Email with secondary color
                    Text(user?.email ?? "No Email")
                        .foregroundColor(.secondary)

                    // Followers and Following stats
                    HStack(spacing: 40) {
                        VStack {
                            Text("120").bold().foregroundColor(.primary)
                            Text("Followers").foregroundColor(.secondary)
                        }
                        VStack {
                            Text("85").bold().foregroundColor(.primary)
                            Text("Following").foregroundColor(.secondary)
                        }
                    }

                    // Navigation Links to other profile sections
                    VStack(spacing: 16) {
                        NavigationLink(destination: UserPlaylistView()) {
                            ProfileRow(title: "Your Playlists", icon: "music.note.list")
                        }
                        NavigationLink(destination: LikedSongsView()) {
                            ProfileRow(title: "Liked Songs", icon: "heart.fill")
                        }
                        NavigationLink(destination: SettingsView()) {
                            ProfileRow(title: "Settings", icon: "gearshape.fill")
                        }
                        ProfileRow(title: "Log Out", icon: "arrow.backward.circle.fill")
                    }
                }
                .padding()
                // Background adapts to system appearance (light/dark)
                .background(Color(UIColor.systemBackground))
            }
            // Edges ignore safe area for fullscreen background effect
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
            .onAppear {
                // Load latest user data from Core Data
                user = CoreDataManager.shared.fetchLatestUser()
                if let data = user?.profileImage, let uiImage = UIImage(data: data) {
                    profileImage = uiImage
                }
            }
        }
    }

    // Save picked profile image to Core Data
    func saveProfileImage() {
        guard let user = user, let image = profileImage, let data = image.jpegData(compressionQuality: 0.8) else { return }
        user.profileImage = data
        CoreDataManager.shared.saveContext()
        print("✅ Profile image saved")
    }
}

// ProfileRow reusable view with adaptive colors
struct ProfileRow: View {
    let title: String
    let icon: String
    var color: Color = .primary // Default to primary color for text

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.green)
                .frame(width: 32)
            Text(title)
                .foregroundColor(color)
                .font(.headline)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground)) // Adaptive background color
        .cornerRadius(10)
    }
}
