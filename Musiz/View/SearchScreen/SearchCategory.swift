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
    @StateObject private var audioVM = AudioPlayerViewModel()

    let categories = [
        SearchCategory(title: "Podcasts", color: .purple, image: "15"),
        SearchCategory(title: "Charts", color: .blue, image: "22"),
        SearchCategory(title: "New Releases", color: .green, image: "17"),
        SearchCategory(title: "Workout", color: .orange, image: "30"),
        SearchCategory(title: "Chill", color: .pink, image: "28")
    ]
    
    // Use your existing song list
    let allSongs = recommendedSongs + topMixes + moodBooster


    var filteredSongs: [Song] {
        if searchText.isEmpty {
            return allSongs
        } else {
            return allSongs.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.artist.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Search")
                        .font(.largeTitle).bold().foregroundColor(.white)
                        .padding(.horizontal)

                    TextField("What do you want to listen to?", text: $searchText)
                        .padding(12)
                        .background(Color(.darkGray))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    if !searchText.isEmpty {
                        Text("Results")
                            .font(.title2).bold().foregroundColor(.white)
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
                                    .padding(.horizontal)
                                }
                            }
                        }
                    } else {
                        Text("Browse all")
                            .font(.title2).bold().foregroundColor(.white)
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
                                        .padding(.bottom,35)
                                    
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
    }
}
