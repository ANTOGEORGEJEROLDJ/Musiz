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
        ZStack {
            Color.black.ignoresSafeArea() // Full black background

            VStack(alignment: .leading) {
                // Custom Header
                Text(playlistTitle)
                    .font(.largeTitle.bold())
                    .foregroundColor(.green)
                    .padding([.top, .horizontal])

                // List of Songs
                List {
                    ForEach(songs) { song in
                        NavigationLink(destination: SongDetailView(song: song, audioVM: audioVM)) {
                            HStack(spacing: 12) {
                                Image(song.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(8)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(song.title)
                                        .font(.headline)
                                        .foregroundColor(.white)

                                    Text(song.artist)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }

                                Spacer()

                                Image(systemName: "play.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.title2)
                            }
                            .padding(.vertical, 8)
                        }
                        .listRowBackground(Color.black)
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    }
                }
                .listStyle(PlainListStyle())
                .onAppear {
                    UITableView.appearance().backgroundColor = .black
                    UITableViewCell.appearance().backgroundColor = .black
                }
            }
        }
    }
}
