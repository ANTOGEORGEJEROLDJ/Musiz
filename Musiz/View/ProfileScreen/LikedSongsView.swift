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
                            .frame(width: 60, height: 60)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            Text(song.title).foregroundColor(.white).bold()
                            Text(song.artist).foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color(.darkGray))
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle("Liked Songs")
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            likedSongs = CoreDataManager.shared.fetchLikedSongs()
        }
    }
}
