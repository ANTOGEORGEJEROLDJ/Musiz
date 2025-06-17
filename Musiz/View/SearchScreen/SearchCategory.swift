//
//  SearchCategory.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

struct SearchCategory: Identifiable {
    let id = UUID()
    let title: String
    let color: Color
    let image: String
}

struct SpotifySearchView: View {
    @State private var searchText = ""
    @State private var selectedGenre = "All"
    @StateObject private var audioVM = AudioPlayerViewModel()
    @Environment(\.colorScheme) var colorScheme  // Detect Light/Dark Mode

    // Sample categories
    let categories = [
        SearchCategory(title: "Pop", color: .purple, image: "15"),
        SearchCategory(title: "Rock", color: .blue, image: "22"),
        SearchCategory(title: "Jazz", color: .green, image: "17"),
        SearchCategory(title: "Album", color: .orange, image: "30"),
        SearchCategory(title: "Chill", color: .pink, image: "28")
    ]

    let genres = ["All", "Pop", "Rock", "Jazz", "Chill", "Album"]

    // Sample data source
    let allSongs = recommendedSongs + topMixes + moodBooster

    // Filtering based on genre and search text
    var filteredSongs: [Song] {
        allSongs.filter { song in
            (selectedGenre == "All" || song.genre == selectedGenre) &&
            (searchText.isEmpty ||
             song.title.localizedCaseInsensitiveContains(searchText) ||
             song.artist.localizedCaseInsensitiveContains(searchText))
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    // Main Title
                    Text("Search")
                        .font(.largeTitle).bold()
                        .foregroundColor(.primary)
                        .padding(.horizontal)

                    // Search TextField
                    TextField("What do you want to listen to?", text: $searchText)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.secondarySystemBackground))
                        )
                        .foregroundColor(.primary)
                        .padding(.horizontal)

                    // Genre Picker
                    Picker("Select Genre", selection: $selectedGenre) {
                        ForEach(genres, id: \.self) { genre in
                            Text(genre).tag(genre)
                        }
                    }
                    .padding(.horizontal)
                    .pickerStyle(SegmentedPickerStyle())

                    // Search Results
                    if !filteredSongs.isEmpty {
                        Text("Results")
                            .font(.title2).bold()
                            .foregroundColor(.primary)
                            .padding(.horizontal)

                        LazyVStack(alignment: .leading, spacing: 16) {
                            ForEach(filteredSongs) { song in
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
                                    .padding(.horizontal)
                                }
                            }
                        }
                    } else if searchText.isEmpty && selectedGenre == "All" {
                        // Show category grid
                        Text("Browse all")
                            .font(.title2).bold()
                            .foregroundColor(.primary)
                            .padding(.horizontal)

                        LazyVGrid(columns: [GridItem(), GridItem()]) {
                            ForEach(categories) { cat in
                                ZStack(alignment: .bottomLeading) {
                                    Rectangle()
                                        .fill(cat.color)
                                        .cornerRadius(10)
                                        .frame(height: 100)

                                    Text(cat.title)
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding()

                                    Image(cat.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .opacity(0.8)
                                        .cornerRadius(14)
                                        .padding(.leading, 100)
                                        .padding(.bottom, 35)
                                }
                            }
                        }
                        .padding()
                    } else {
                        // No results found
                        Text("No results found")
                            .foregroundColor(.secondary)
                            .padding()
                    }
                }
                .padding(.top)
            }
            .background(Color(.systemBackground)) // Adaptive background
            .navigationBarHidden(true)
        }
    }
}
