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
    description: "All your favorite tracks here",
    owner: "Spotify",
    imageName: "1",
    songs: [
        Song(title: "Happy Now", artist: "Zedd", imageName: "2", fileName: "happy_now", genre: "Chill"),
        Song(title: "Sunshine", artist: "OneRepublic", imageName: "3", fileName: "sunshine", genre: "Chill"),
        Song(title: "Elevate", artist: "Drake", imageName: "4", fileName: "elevate", genre: "Chill"),
        Song(title: "Good Vibes", artist: "Khalid", imageName: "5", fileName: "good_vibes", genre: "Chill"),
        Song(title: "Feel Alive", artist: "Lost Frequencies", imageName: "6", fileName: "feel_alive", genre: "Chill"),
        Song(title: "Bright Side", artist: "Imagine Dragons", imageName: "7", fileName: "bright_side", genre: "Chill"),
        Song(title: "On Top", artist: "Calvin Harris", imageName: "8", fileName: "on_top", genre: "Chill"),
        Song(title: "Shine", artist: "Lizzo", imageName: "9", fileName: "shine", genre: "Chill"),
        Song(title: "Celebrate", artist: "Pitbull", imageName: "10", fileName: "celebrate", genre: "Chill"),
        Song(title: "Rise Up", artist: "Andra Day", imageName: "11", fileName: "rise_up", genre: "Chill"),
        Song(title: "Jumpstart", artist: "Sia", imageName: "12", fileName: "jumpstart", genre: "Chill"),
        Song(title: "Bright Lights", artist: "Ellie Goulding", imageName: "1", fileName: "bright_lights", genre: "Chill")
    ]
    
)



struct MainTabView: View {
    @State private var selectedTab = 0
    @StateObject private var audioVM = AudioPlayerViewModel()

    init() {
        // Customize UITabBar appearance globally
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        // Background color adapts automatically:
        // - Black in dark mode
        // - White in light mode
        appearance.backgroundColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
        // Set the appearance for standard and scrollEdgeAppearance
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        // Unselected icons color adapt to mode for visibility:
        // - Light gray in dark mode
        // - Dark gray in light mode
        UITabBar.appearance().unselectedItemTintColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? .lightGray : .darkGray
        }
    }

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

            UserPlaylistView(songToAdd: nil)
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
        // Accent color applies to selected tab icon and text
        // Green color works well in both modes
        .accentColor(.green)
        // Background color of the whole TabView:
        // Black in dark mode, white in light mode automatically
        .background(Color("BackgroundColor").ignoresSafeArea())
        // Hides navigation back button if inside NavigationView
        .navigationBarBackButtonHidden(true)
    }
}
