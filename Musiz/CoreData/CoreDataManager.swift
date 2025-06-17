
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

    // Easier access to main context
    var context: NSManagedObjectContext {
        container.viewContext
    }

    private init() {
        container = NSPersistentContainer(name: "Model") // ⚠️ Must match .xcdatamodeld filename
        container.loadPersistentStores { _, error in
            if let error = error {
                print("❌ Core Data failed to load: \(error)")
            }
        }
    }

    // MARK: - Device Library: Saved Songs
    
    func saveSong(title: String, artist: String, imageName: String) {
        let song = SavedSong(context: context)
        song.title = title
        song.artist = artist
        song.imageName = imageName

        saveContext()
        print("✅ Song saved to device: \(title)")
    }

    func fetchSavedSongs() -> [SavedSong] {
        let request: NSFetchRequest<SavedSong> = SavedSong.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("❌ Failed to fetch saved songs: \(error.localizedDescription)")
            return []
        }
    }

    // MARK: - Playlist Management
    
    func savePlaylist(name: String) {
        let playlist = UserPlaylist(context: context)
        playlist.name = name

        saveContext()
        print("✅ Playlist created: \(name)")
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

    // MARK: - Add Song to Playlist (Avoid Duplicate)

    func addSong(_ song: Song, to playlist: UserPlaylist) {
        let existingSongs = fetchSongs(for: playlist)
        
        if existingSongs.contains(where: { $0.id == song.id }) {
            print("⚠️ Song already exists in playlist: \(song.title)")
            return
        }

        let playlistSong = PlaylistSong(context: context)
        playlistSong.id = song.id
        playlistSong.title = song.title
        playlistSong.artist = song.artist
        playlistSong.imageName = song.imageName
        playlistSong.playlist = playlist

        saveContext()
        print("✅ Added '\(song.title)' to playlist '\(playlist.name ?? "Unnamed")'")
    }

    // MARK: - Fetch Songs in Playlist

    func fetchSongs(for playlist: UserPlaylist) -> [PlaylistSong] {
        do {
            if let refreshedPlaylist = try context.existingObject(with: playlist.objectID) as? UserPlaylist {
                return (refreshedPlaylist.songs as? Set<PlaylistSong>)?.sorted {
                    ($0.title ?? "") < ($1.title ?? "")
                } ?? []
            }
        } catch {
            print("Failed to fetch playlist for songs: \(error)")
        }
        return []
    }


    // MARK: - Remove Song from Playlist

    func removeSong(_ song: PlaylistSong, from playlist: UserPlaylist) {
        context.delete(song)
        saveContext()
        print("🗑️ Removed '\(song.title ?? "")' from '\(playlist.name ?? "")'")
    }

    // MARK: - Save Context Helper

     func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("❌ Core Data Save Error: \(error.localizedDescription)")
            }
        }
    }
    
    func saveLikedSong(_ song: Song) {
        let context = container.viewContext
        let likedSong = LikedSong(context: context)
        likedSong.id = song.id.uuidString
        likedSong.title = song.title
        likedSong.artist = song.artist
        likedSong.imageName = song.imageName
        likedSong.fileName = song.fileName
        likedSong.genre = song.genre

        do {
            try context.save()
            print("✅ Liked song saved: \(song.title)")
        } catch {
            print("❌ Failed to save liked song: \(error.localizedDescription)")
        }
    }
    
    // MARK: - User Login Save and Fetch

        func saveUser(username: String, email: String, password: String) {
            let user = User(context: context)
            user.username = username
            user.email = email
            user.password = password

            saveContext()
            print("✅ User saved: \(username)")
        }

        func fetchLatestUser() -> User? {
            let request: NSFetchRequest<User> = User.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \User.username, ascending: true)]
            request.fetchLimit = 1

            do {
                return try context.fetch(request).last
            } catch {
                print("❌ Failed to fetch user: \(error.localizedDescription)")
                return nil
            }
        }
    
    func fetchLikedSongs() -> [Song] {
        let context = container.viewContext
        let request = NSFetchRequest<LikedSong>(entityName: "LikedSong")

        do {
            let results = try context.fetch(request)
            return results.map {
                Song(
                     title: $0.title ?? "",
                     artist: $0.artist ?? "",
                     imageName: $0.imageName ?? "defaultImage",
                     fileName: $0.fileName ?? "", genre: $0.genre ?? "")
            }
        } catch {
            print("Failed to fetch liked songs: \(error)")
            return []
        }
    }

    


}
