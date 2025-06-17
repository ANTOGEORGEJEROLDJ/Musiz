//
//  PlayList.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import Foundation

// MARK: - Playlist Model

struct Playlist: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let owner: String
    let imageName: String
    let songs: [Song]
}
