//
//  PlaylistView.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI


struct PlaylistView: View {
    var playlist: Playlist
    @ObservedObject var audioVM: AudioPlayerViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(playlist.imageName)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding(.horizontal)

                Text(playlist.title)
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal)

                Text(playlist.description)
                    .foregroundColor(.gray)
                    .padding(.horizontal)

                Text("By \(playlist.owner) • \(playlist.songs.count) songs")
                    .foregroundColor(.gray)
                    .padding(.horizontal)

                Button(action: {
                    if let first = playlist.songs.first {
                        audioVM.playSong(first) // ✅ Correct
                    }
                }) {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Play")
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(30)
                    .foregroundColor(.black)
                }
                .padding(.horizontal)

                VStack(spacing: 16) {
                    ForEach(playlist.songs) { song in
                        NavigationLink(destination: SongDetailView(song: song, audioVM: audioVM)) {
                            HStack {
                                Image(song.imageName)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(5)

                                VStack(alignment: .leading) {
                                    Text(song.title)
                                        .bold()
                                        .foregroundColor(.white)
                                    Text(song.artist)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }

                                Spacer()

                                Image(systemName: "ellipsis")
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationTitle(playlist.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
