//
//  PlaylistSelectionSheet.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//


import SwiftUI

struct PlaylistSelectionSheet: View {
    var playlists: [UserPlaylist]
    var songToAdd: Song
    var onDismiss: () -> Void

    var body: some View {
        NavigationView {
            List {
                if playlists.isEmpty {
                    Text("No playlists found.")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                } else {
                    ForEach(playlists, id: \.self) { playlist in
                        Button(action: {
                            CoreDataManager.shared.addSong(songToAdd, to: playlist)
                            onDismiss()
                        }) {
                            HStack {
                                Text(playlist.name ?? "Unnamed Playlist")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Select Playlist")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        onDismiss()
                    }
                }
            }
        }
        .preferredColorScheme(nil) // Follows system Light/Dark Mode
    }
}
