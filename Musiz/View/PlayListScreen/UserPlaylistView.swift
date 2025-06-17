//
//  UserPlaylistView.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

struct UserPlaylistView: View {
    @State private var savedSongs: [SavedSong] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(savedSongs) { song in
                    HStack {
                        Image(song.imageName ?? "placeholder")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)

                        VStack(alignment: .leading) {
                            Text(song.title ?? "Unknown")
                                .bold()
                            Text(song.artist ?? "")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            .onAppear {
                savedSongs = CoreDataManager.shared.fetchSavedSongs()
            }
            .navigationTitle("My Playlist")
        }
    }
}
