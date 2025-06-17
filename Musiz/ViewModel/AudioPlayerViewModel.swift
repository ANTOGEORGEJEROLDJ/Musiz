//
//  AudioPlayerViewModel.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import Foundation
import AVFAudio

// MARK: - Audio Player ViewModel

class AudioPlayerViewModel: ObservableObject {
    var player: AVAudioPlayer?

    @Published var currentlyPlaying: Song?

    func playSong(_ song: Song) {
        guard let url = Bundle.main.url(forResource: song.fileName, withExtension: "mp3") else {
            print("❌ File not found: \(song.fileName).mp3")
            return
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
            currentlyPlaying = song

            print("✅ Now playing: \(song.title)")
        } catch {
            print("❌ Playback error: \(error.localizedDescription)")
        }
    }
    
    func stop() {
        player?.stop()
        currentlyPlaying = nil
    }
    
    

}
