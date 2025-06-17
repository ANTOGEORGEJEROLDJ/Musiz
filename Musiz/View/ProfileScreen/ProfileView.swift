//
//  ProfileView.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var user: User?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    Image("5")
                        .resizable().scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle()).overlay(Circle().stroke(Color.green, lineWidth: 2))

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
                        // ✅ NavigationLink only here
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
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
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
