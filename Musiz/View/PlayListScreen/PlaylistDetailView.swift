//
//  PlaylistDetailView.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

struct PlaylistDetailView: View {
    var playlist: UserPlaylist
    @State private var songs: [PlaylistSong] = []

    var body: some View {
        VStack {
            // Playlist title with large bold font
            Text(playlist.name ?? "Playlist")
                .font(.largeTitle.bold())
                .padding()
                .foregroundColor(.primary) // adapts to light/dark mode

            // List of songs in the playlist
            List {
                ForEach(songs, id: \.self) { song in
                    HStack(spacing: 12) {
                        // Song image or placeholder if missing
                        Image(song.imageName ?? "placeholder")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                            .clipped()

                        // Song details: title and artist
                        VStack(alignment: .leading) {
                            Text(song.title ?? "Unknown")
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text(song.artist ?? "")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .listStyle(PlainListStyle())
            .background(Color(.systemBackground)) // adaptive background
        }
        .background(Color(.systemBackground).ignoresSafeArea()) // full screen background
        .onAppear {
            // Fetch songs belonging to the playlist when view appears
            songs = CoreDataManager.shared.fetchSongs(for: playlist)
            print("Loaded songs count: \(songs.count)")
        }
    }
}
