//
//  SongCard.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

// MARK: - Song Card View

struct SongCard: View {
    let song: Song
    @ObservedObject var audioVM: AudioPlayerViewModel
    
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
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text(song.artist)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            .frame(width: 140)
        }
    }
}


