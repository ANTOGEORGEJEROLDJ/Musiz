//
//  CoreDataManager.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let container: NSPersistentContainer

    // Computed property for easier context access
    var context: NSManagedObjectContext {
        container.viewContext
    }

    init() {
        container = NSPersistentContainer(name: "Model") // Ensure this matches your .xcdatamodeld file name
        container.loadPersistentStores { _, error in
            if let error = error {
                print("❌ Core Data failed: \(error)")
            }
        }
    }

    // MARK: - Saved Song Methods (Device Library)
    
    func saveSong(title: String, artist: String, imageName: String) {
        let song = SavedSong(context: context)
        song.title = title
        song.artist = artist
        song.imageName = imageName

        do {
            try context.save()
            print("✅ Song saved: \(title)")
        } catch {
            print("❌ Failed to save: \(error.localizedDescription)")
        }
    }

    func fetchSavedSongs() -> [SavedSong] {
        let request: NSFetchRequest<SavedSong> = SavedSong.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("❌ Fetch error: \(error)")
            return []
        }
    }

    // MARK: - Playlist Methods
    
    func savePlaylist(name: String) {
        let playlist = UserPlaylist(context: context)
        playlist.name = name

        do {
            try context.save()
            print("✅ Playlist saved: \(name)")
        } catch {
            print("❌ Failed to save playlist: \(error.localizedDescription)")
        }
    }

    func fetchPlaylists() -> [UserPlaylist] {
        let request: NSFetchRequest<UserPlaylist> = UserPlaylist.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("❌ Failed to fetch playlists: \(error.localizedDescription)")
            return []
        }
    }

    func addSong(_ song: Song, to playlist: UserPlaylist) {
        let existingSongs = fetchSongs(for: playlist)
        
        // Avoid duplicates using UUID
        if existingSongs.contains(where: { $0.id == song.id }) {
            print("⚠️ Song already exists in playlist")
            return
        }

        let newSong = PlaylistSong(context: context)
        newSong.id = song.id // Store the UUID
        newSong.title = song.title
        newSong.artist = song.artist
        newSong.imageName = song.imageName
        newSong.playlist = playlist

        do {
            try context.save()
            print("✅ Song added to playlist: \(song.title)")
        } catch {
            print("❌ Failed to add song to playlist: \(error)")
        }
    }


    func fetchSongs(for playlist: UserPlaylist) -> [PlaylistSong] {
        return (playlist.songs as? Set<PlaylistSong>)?.sorted {
            ($0.title ?? "") < ($1.title ?? "")
        } ?? []
    }

    // MARK: - Optional: Delete Song From Playlist
    
    func removeSong(_ song: PlaylistSong, from playlist: UserPlaylist) {
        context.delete(song)
        do {
            try context.save()
            print("🗑️ Removed song from playlist")
        } catch {
            print("❌ Failed to remove song: \(error)")
        }
    }
}
