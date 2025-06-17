//
//  SongDetailView.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI
import AVFoundation

struct SongDetailView: View {
    let song: Song
    @ObservedObject var audioVM: AudioPlayerViewModel
    
    // Playback progress state (0 to song length in seconds)
    @State private var playbackProgress: Double = 0
    @State private var isPlaying: Bool = false
    
    // Callbacks for next/previous song control
    var onNext: (() -> Void)?
    var onPrevious: (() -> Void)?
    
    // Timer for updating slider progress
    @State private var timer: Timer? = nil
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            ScrollView{
                VStack(spacing: 30) {
                    
                    Text("PLAYING FROM ALBUM")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Spacer()
                    
                    Image(song.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .cornerRadius(15)
                        .shadow(radius: 10)
                        .padding(.top, -60)
                    
                    VStack() {
                        Text(song.title)
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Text(song.artist)
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, -50)
                    
                    // Playback slider + time labels
                    VStack {
                        Slider(value: $playbackProgress, in: 0...(audioVM.player?.duration ?? 1), onEditingChanged: sliderEditingChanged)
                            .accentColor(.green)
                        
                        HStack {
                            Text(formatTime(playbackProgress))
                                .foregroundColor(.gray)
                                .font(.caption)
                            Spacer()
                            Text(formatTime(audioVM.player?.duration ?? 0))
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        .padding(.horizontal, 4)
                    }
                    .padding(.horizontal)
                    .padding(.top, -30)
                    
                    VStack{
                    // Playback control buttons: Previous, Play/Pause, Next
                    HStack(spacing: 60) {
                        Button(action: {
                            audioVM.stop()
                            isPlaying = false
                            playbackProgress = 0
                            onPrevious?()
                        }) {
                            Image(systemName: "backward.end.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        
                        Button(action: {
                            if isPlaying {
                                audioVM.stop()
                                stopTimer()
                            } else {
                                audioVM.playSong(song)
                                startTimer()
                            }
                            isPlaying.toggle()
                        }) {
                            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        
                        Button(action: {
                            audioVM.stop()
                            isPlaying = false
                            playbackProgress = 0
                            onNext?()
                        }) {
                            Image(systemName: "forward.end.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white.opacity(0.7))
                        }
                    }
                    }.padding(.top, -20)
                    
                    // Add to playlist button
                    Button(action: {
                        // Your add to playlist logic here
                        print("Add '\(song.title)' to playlist")
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add to Playlist")
                                .bold()
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.black)
                        .cornerRadius(20)
                    }
                    .padding(.top, 20)
                    
                    Button(action: {
                        saveSongLocally(song)
                    }) {
                        HStack {
                            Image(systemName: "square.and.arrow.down.fill")
                            Text("Save to Device")
                                .bold()
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    }
                    .padding(.top, 10)

                    
                    Spacer()
                }
                .padding()
                .onAppear {
                    // Sync isPlaying with audioVM player state
                    isPlaying = audioVM.currentlyPlaying?.id == song.id && audioVM.player?.isPlaying == true
                    playbackProgress = audioVM.player?.currentTime ?? 0
                    if isPlaying {
                        startTimer()
                    }
                }
                .onDisappear {
                    stopTimer()
                    audioVM.stop()
                    isPlaying = false
                }
            }
        }
        
        
    }
    
    func saveSongLocally(_ song: Song) {
        let fileManager = FileManager.default

        // 1. Find source file (in bundle)
        guard let sourceURL = Bundle.main.url(forResource: song.fileName, withExtension: "mp3") else {
            print("❌ File not found in bundle: \(song.fileName).mp3")
            return
        }

        // 2. Destination: Documents folder
        let docsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationURL = docsURL.appendingPathComponent("\(song.fileName).mp3")

        // 3. Copy file if not exists
        if fileManager.fileExists(atPath: destinationURL.path) {
            print("ℹ️ Already saved: \(destinationURL.lastPathComponent)")
        } else {
            do {
                try fileManager.copyItem(at: sourceURL, to: destinationURL)
                print("✅ Saved to: \(destinationURL.path)")
            } catch {
                print("❌ Save failed: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Helpers
    
    func sliderEditingChanged(editingStarted: Bool) {
        if editingStarted {
            stopTimer()
        } else {
            audioVM.player?.currentTime = playbackProgress
            if isPlaying {
                audioVM.player?.play()
                startTimer()
            }
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            if let player = audioVM.player {
                playbackProgress = player.currentTime
                if !player.isPlaying {
                    isPlaying = false
                    stopTimer()
                }
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func formatTime(_ time: Double) -> String {
        let totalSeconds = Int(time)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
