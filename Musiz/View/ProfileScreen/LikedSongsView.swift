//
//  LikedSongsView.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

struct LikedSongsView: View {
    @State private var likedSongs: [Song] = []

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(likedSongs) { song in
                    HStack {
                        Image(song.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .cornerRadius(8)
                            .clipped() // Ensure image fits in frame
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(song.title)
                                .foregroundColor(.primary)
                                .bold()
                            Text(song.artist)
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle("Liked Songs")
        .background(Color(UIColor.systemBackground).ignoresSafeArea())
        .onAppear {
            likedSongs = CoreDataManager.shared.fetchLikedSongs()
        }
    }
}
