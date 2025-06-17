//
//  ProfileView.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    Image("5")
                        .resizable().scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle()).overlay(Circle().stroke(Color.green, lineWidth: 2))

                    Text("Anto").font(.title2).bold().foregroundColor(.white)
                    Text("Anto@gmail.com").foregroundColor(.gray)

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
                        ProfileRow(title: "Your Playlists", icon: "music.note.list")
                        ProfileRow(title: "Liked Songs", icon: "heart.fill")
                        ProfileRow(title: "Settings", icon: "gearshape.fill")
                        ProfileRow(title: "Log Out", icon: "arrow.backward.circle.fill")
                    }
                }
                .padding()
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
            Image(systemName: icon).foregroundColor(color).frame(width: 32)
            Text(title).foregroundColor(color).font(.headline)
            Spacer()
            Image(systemName: "chevron.right").foregroundColor(.gray)
        }
        .padding()
        .background(Color(.darkGray))
        .cornerRadius(10)
    }
}
