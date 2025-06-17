//
//  PlaylistSelectionSheet.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

// PlaylistSelectionSheet.swift
import SwiftUI

struct PlaylistSelectionSheet: View {
    var playlists: [UserPlaylist]
    var songToAdd: Song

    var onDismiss: () -> Void

    var body: some View {
        NavigationView {
            List(playlists, id: \.self) { playlist in
                Button(action: {
                    CoreDataManager.shared.addSong(songToAdd, to: playlist)
                    onDismiss()
                }) {
                    HStack {
                        Text(playlist.name ?? "Unnamed")
                        Spacer()
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Select Playlist")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        onDismiss()
                    }
                }
            }
        }
    }
}
