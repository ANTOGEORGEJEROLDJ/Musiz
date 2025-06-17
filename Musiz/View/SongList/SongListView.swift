//
//  SongListView.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

struct SongListView: View {
    let playlistTitle: String
    let songs: [Song]
    @ObservedObject var audioVM: AudioPlayerViewModel

    var body: some View {
        List(songs) { song in
            NavigationLink(destination: SongDetailView(song: song, audioVM: audioVM)) {
                HStack(spacing: 12) {
                    Image(song.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .cornerRadius(6)
                    
                    VStack(alignment: .leading) {
                        Text(song.title)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(song.artist)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 6)
                .listRowBackground(Color.black)
            }
        }
        .navigationTitle(playlistTitle)
        .listStyle(PlainListStyle())
        .background(Color.black)
        .foregroundColor(.white)
        .onAppear {
            UITableView.appearance().backgroundColor = .black
            UITableViewCell.appearance().backgroundColor = .black
        }
    }
}
