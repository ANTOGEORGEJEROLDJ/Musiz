//
//  ContentView.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

// MARK: - Demo Playlist
let demoPlaylist = Playlist(
    
    title: "Top Hits 2025",
    description: "All your favorite tracks here", // ✅ Added
    owner: "Spotify",                            // ✅ Added
    imageName: "1",
    songs: [
        Song(title: "Chill Beat 1", artist: "Artist A", imageName: "1", fileName: "chill_beat_1"),
        Song(title: "Chill Beat 2", artist: "Artist B", imageName: "2", fileName: "chill_beat_2"),
        Song(title: "Chill Beat 3", artist: "Artist C", imageName: "3", fileName: "chill_beat_3"),
        Song(title: "Chill Beat 4", artist: "Artist D", imageName: "4", fileName: "chill_beat_4"),
        Song(title: "Chill Beat 5", artist: "Artist E", imageName: "5", fileName: "chill_beat_5"),
        Song(title: "Chill Beat 6", artist: "Artist F", imageName: "6", fileName: "chill_beat_6"),
        Song(title: "Chill Beat 7", artist: "Artist G", imageName: "7", fileName: "chill_beat_7"),
        Song(title: "Chill Beat 8", artist: "Artist H", imageName: "8", fileName: "chill_beat_8"),
        Song(title: "Chill Beat 9", artist: "Artist I", imageName: "9", fileName: "chill_beat_9"),
        Song(title: "Chill Beat 10", artist: "Artist J", imageName: "10", fileName: "chill_beat_10")
    ]
    
)


struct MainTabView: View {
    @State private var selectedTab = 0
    @StateObject private var audioVM = AudioPlayerViewModel()

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)

            SpotifySearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)

            PlaylistView(playlist: demoPlaylist, audioVM: audioVM)
                .tabItem {
                    Image(systemName: "music.note.list")
                    Text("Playlist")
                }
                .tag(2)

            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag(3)
        }
        .tint(.green)

    }
}
