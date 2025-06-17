//
//  SongCard.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

struct SongCard: View {
    let song: Song
    @ObservedObject var audioVM: AudioPlayerViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationLink(destination: SongDetailView(song: song, audioVM: audioVM)) {
            VStack(alignment: .leading, spacing: 6) {
                Image(song.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 140)
                    .cornerRadius(8)
                    .shadow(radius: 2)

                Text(song.title)
                    .font(.headline)
                    .foregroundColor(.primary) // Auto-adapts to dark/light mode
                    .lineLimit(1)

                Text(song.artist)
                    .font(.subheadline)
                    .foregroundColor(.secondary) // Slightly dimmer text, adaptive
                    .lineLimit(1)
            }
            .frame(width: 140)
        }
    }
}
