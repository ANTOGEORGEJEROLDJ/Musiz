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
                Color(.systemBackground) // Adaptive background
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 16) {
                    // MARK: - Header
                    HStack {
                        Text("My Playlists")
                            .font(.largeTitle.bold())
                            .foregroundColor(.primary)

                        Spacer()

                        // Show Add Playlist Sheet
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

                    // MARK: - Playlist List
                    List {
                        ForEach(playlists) { playlist in
                            if let song = songToAdd {
                                // Mode: Add Song to Playlist
                                HStack(spacing: 12) {
                                    Image("2") // Replace with dynamic thumbnail if needed
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(playlist.name ?? "Unnamed")
                                            .font(.headline)
                                            .foregroundColor(.primary)

                                        Text("UserName") // Replace with dynamic user name
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
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
                                // Mode: Navigate to Playlist Detail
                                NavigationLink(destination: PlaylistDetailView(playlist: playlist)) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(playlist.name ?? "Unnamed")
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                        }

                                        Spacer()

                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.vertical, 8)
                                }
                            }
                        }
                        .listRowBackground(Color(.systemBackground)) // Adapt row background
                    }
                    .listStyle(PlainListStyle())
                    .onAppear {
                        playlists = CoreDataManager.shared.fetchPlaylists()
                    }

                    Spacer()
                }
            }
            .navigationBarHidden(true)

            // MARK: - Add Playlist Sheet
            .sheet(isPresented: $showAddView) {
                AddPlaylistView {
                    playlists = CoreDataManager.shared.fetchPlaylists()
                }
            }
        }
    }
}
