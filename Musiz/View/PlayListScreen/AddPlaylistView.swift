//
//  AddPlaylistView.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

struct AddPlaylistView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var playlistName: String = ""

    var onSave: (() -> Void)? // Callback to refresh playlists in parent view

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // MARK: - Header
                Text("Create New Playlist")
                    .font(.title2.bold())
                    .foregroundColor(.primary)

                // MARK: - Text Field for Name Input
                TextField("Enter playlist name", text: $playlistName)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .foregroundColor(.primary)
                    .padding(.horizontal)

                // MARK: - Save Button
                Button(action: {
                    guard !playlistName.isEmpty else { return }
                    CoreDataManager.shared.savePlaylist(name: playlistName)
                    onSave?()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }

                Spacer()
            }
            .padding(.top, 40)
        }
    }
}

#Preview {
    Group {
        AddPlaylistView()
            .preferredColorScheme(.light)

        AddPlaylistView()
            .preferredColorScheme(.dark)
    }
}
