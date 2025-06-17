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
            Text(playlist.name ?? "Playlist")
                .font(.largeTitle.bold())
                .padding()

            List {
                ForEach(songs, id: \.self) { song in
                    HStack {
                        Image(song.imageName ?? "placeholder")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                        VStack(alignment: .leading) {
                            Text(song.title ?? "Unknown")
                                .font(.headline)
                            Text(song.artist ?? "")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .onAppear {
            songs = CoreDataManager.shared.fetchSongs(for: playlist)
            print("Loaded songs count: \(songs.count)")
        }
    }
}
