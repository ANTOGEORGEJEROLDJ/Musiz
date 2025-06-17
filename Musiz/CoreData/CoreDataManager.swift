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

    init() {
        container = NSPersistentContainer(name: "Model") // Change to your Core Data model name
        container.loadPersistentStores { _, error in
            if let error = error {
                print("❌ Core Data failed: \(error)")
            }
        }
    }

    func saveSong(title: String, artist: String, imageName: String) {
        let context = container.viewContext
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
            return try container.viewContext.fetch(request)
        } catch {
            print("❌ Fetch error: \(error)")
            return []
        }
    }
}

