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

    var onSave: (() -> Void)? // Callback to refresh playlists in previous screen

    var body: some View {
        VStack(spacing: 20) {
            Text("Create New Playlist")
                .font(.title2.bold())

            TextField("Enter playlist name", text: $playlistName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button(action: {
                guard !playlistName.isEmpty else { return }
                CoreDataManager.shared.savePlaylist(name: playlistName)
                onSave?()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .padding(.top)
    }
    
}
#Preview {
    AddPlaylistView()
}
