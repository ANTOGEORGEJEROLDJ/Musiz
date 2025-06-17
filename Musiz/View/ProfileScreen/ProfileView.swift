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
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        if let image = profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
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

                    Text(user?.username ?? "No Name").font(.title2).bold().foregroundColor(.white)
                    Text(user?.email ?? "No Email").foregroundColor(.gray)

                    HStack(spacing: 40) {
                        VStack {
                            Text("120").bold().foregroundColor(.white)
                            Text("Followers").foregroundColor(.gray)
                        }
                        VStack {
                            Text("85").bold().foregroundColor(.white)
                            Text("Following").foregroundColor(.gray)
                        }
                    }

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
                .onAppear {
                    user = CoreDataManager.shared.fetchLatestUser()
                    if let data = user?.profileImage, let uiImage = UIImage(data: data) {
                        profileImage = uiImage
                    }
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
    }

    func saveProfileImage() {
        guard let user = user, let image = profileImage, let data = image.jpegData(compressionQuality: 0.8) else { return }
        user.profileImage = data
        CoreDataManager.shared.saveContext()
        print("✅ Profile image saved")
    }
}
struct ProfileRow: View {
    let title: String, icon: String, color: Color = .white
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.green)
                .frame(width: 32)
            Text(title)
                .foregroundColor(color)
                .font(.headline)
            Spacer()
            Image(systemName: "chevron.right").foregroundColor(.gray)
        }
        .padding()
        .background(Color(.darkGray))
        .cornerRadius(10)
    }
}
