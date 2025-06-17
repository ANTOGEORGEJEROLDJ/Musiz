//
//  UserPlaylistView.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

struct UserPlaylistView: View {
    @State private var playlists: [UserPlaylist] = []
    @State private var showAddView = false

    // Optional song passed from SongDetailView
    var songToAdd: Song?

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("My Playlists")
                        .font(.title2.bold())
                    Spacer()
                    Button(action: {
                        showAddView = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.green)
                    }
                }
                .padding(.horizontal)
                .padding(.top)

                List {
                    ForEach(playlists) { playlist in
                        Button(action: {
                            if let song = songToAdd {
                                CoreDataManager.shared.addSong(song, to: playlist)
                            }
                        }) {
                            NavigationLink(destination: PlaylistDetailView(playlist: playlist)) {
                                Text(playlist.name ?? "Unnamed")
                                    .font(.headline)
                            }
                        }
                    }

                }
                .listStyle(PlainListStyle())
                .onAppear {
                    playlists = CoreDataManager.shared.fetchPlaylists()
                }

                Spacer()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $showAddView) {
                AddPlaylistView {
                    playlists = CoreDataManager.shared.fetchPlaylists()
                }
            }
        }
    }
}
