//
//  PlaylistSelectionSheet.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

// PlaylistSelectionSheet.swift
import SwiftUI

struct PlaylistSelectionSheet: View {
    let playlists: [UserPlaylist]
    let songToAdd: Song
    let onDismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Select a Playlist")
                .font(.headline)
                .padding()

            ForEach(playlists) { playlist in
                Button(action: {
                    CoreDataManager.shared.addSong(songToAdd, to: playlist)
                    onDismiss()
                }) {
                    Text(playlist.name ?? "Unnamed")
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(10)
                }
            }

            Button("Cancel") {
                onDismiss()
            }
            .foregroundColor(.red)
            .padding(.top)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .padding()
    }
}
