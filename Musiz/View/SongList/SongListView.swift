//
//  SongListView.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

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

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            // Adaptive background
            Color(UIColor.systemBackground)
                .ignoresSafeArea()

            VStack(alignment: .leading) {
                // Custom Header
                Text(playlistTitle)
                    .font(.largeTitle.bold())
                    .foregroundColor(.accentColor)
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
                                        .foregroundColor(.primary)

                                    Text(song.artist)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()

                                Image(systemName: "play.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.title2)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        // Set appearance for UIKit elements on appear
        .onAppear {
            let bgColor = UIColor.systemBackground
            UITableView.appearance().backgroundColor = bgColor
            UITableViewCell.appearance().backgroundColor = bgColor
        }
        .onDisappear {
            UITableView.appearance().backgroundColor = nil
            UITableViewCell.appearance().backgroundColor = nil
        }
    }
}
