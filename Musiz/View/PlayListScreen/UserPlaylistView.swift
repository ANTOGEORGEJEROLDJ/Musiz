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

    var songToAdd: Song?

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(alignment: .leading, spacing: 16) {
                    // Header
                    HStack {
                        Text("My Playlists")
                            .font(.largeTitle.bold())
                            .foregroundColor(.green)
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

                    // Playlist List
                    List {
                        ForEach(playlists) { playlist in
                            if let song = songToAdd {
                                HStack(spacing: 12) {
                                    Image("2") // Replace with dynamic thumbnail if available
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(playlist.name ?? "Unnamed")
                                            .font(.headline)
                                            .foregroundColor(.white)

                                        Text("UserName") // Replace with actual username if available
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }

                                    Spacer()

                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.green)
                                }
                                .contentShape(Rectangle())
                                .padding(.vertical, 8)
                                .onTapGesture {
                                    CoreDataManager.shared.addSong(song, to: playlist)
                                    playlists = CoreDataManager.shared.fetchPlaylists()
                                }
                            } else {
                                NavigationLink(destination: PlaylistDetailView(playlist: playlist)) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(playlist.name ?? "Unnamed")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                        }

                                        Spacer()

                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.vertical, 8)
                                }
                            }
                        }
                        .listRowBackground(Color.black)
                    }
                    .listStyle(PlainListStyle())
                    .onAppear {
                        playlists = CoreDataManager.shared.fetchPlaylists()
                    }

                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showAddView) {
                AddPlaylistView {
                    playlists = CoreDataManager.shared.fetchPlaylists()
                }
            }
        }
    }
}
