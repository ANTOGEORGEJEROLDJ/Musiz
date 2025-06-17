//
//  SectionView.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

struct SectionView: View {
    let title: String
    let songs: [Song]
    @ObservedObject var audioVM: AudioPlayerViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.title2.bold())
                    .foregroundColor(.primary) // Adapts to light/dark mode
                
                Spacer()
                
                NavigationLink(destination: SongListView(playlistTitle: title, songs: songs, audioVM: audioVM)) {
                    Text("See All")
                        .font(.subheadline)
                        .foregroundColor(.green) // Keep this fixed for consistent branding
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(songs) { song in
                        SongCard(song: song, audioVM: audioVM)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
