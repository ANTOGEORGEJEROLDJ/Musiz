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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                
                Spacer()
                
                NavigationLink(destination: SongListView(playlistTitle: title, songs: songs, audioVM: audioVM)) {
                    Text("See All")
                        .font(.subheadline)
                        .foregroundColor(.green)
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
