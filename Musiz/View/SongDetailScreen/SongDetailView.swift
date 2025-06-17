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
    @State private var showSleepTimer = false
    
    @State private var playbackProgress: Double = 0
    @State private var isPlaying: Bool = false
    @State private var showPlaylist = false
    @State private var showBottomSheet = false
    @State private var allPlaylists: [UserPlaylist] = []

    var onNext: (() -> Void)?
    var onPrevious: (() -> Void)?
    
    @State private var timer: Timer? = nil

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    
                    Text("PLAYING FROM ALBUM")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Image(song.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .cornerRadius(15)
                        .shadow(radius: 10)
                        .padding(.top, -60)
                    
                    VStack {
                        HStack {
                            VStack {
                                Text(song.title)
                                    .font(.title2.bold())
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.center)
                                
                                Text(song.artist)
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.top, -10)
                            
                            Spacer()
                            
                            Button(action: {
                                showSleepTimer = true
                            }) {
                                Image("timeIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .tint(.green)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.green)
                            }
                            .padding(.top, -10)
                            .sheet(isPresented: $showSleepTimer) {
                                SleepTimerView(player: audioVM.player)
                            }
                            
                            Button(action: {
                                CoreDataManager.shared.saveLikedSong(song)
                            }) {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.green)
                            }
                            .padding(.top, -10)
                            
                            Button(action: {
                                shareSong(song)
                            }) {
                                Image("share")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.green)
                            }
                            .padding(.top, -10)
                        }
                        .padding()
                        .padding(.top, -40)
                        
                        // Playback slider
                        VStack {
                            Slider(value: $playbackProgress, in: 0...(audioVM.player?.duration ?? 1), onEditingChanged: sliderEditingChanged)
                                .accentColor(.green)
                            
                            HStack {
                                Text(formatTime(playbackProgress))
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                                Spacer()
                                Text(formatTime(audioVM.player?.duration ?? 0))
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                            }
                            .padding(.horizontal, 4)
                        }
                        .padding(.horizontal)
                        .padding(.top, -15)
                        
                        // Playback controls
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
                                    .foregroundColor(.primary.opacity(0.7))
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
                                    .foregroundColor(.primary.opacity(0.7))
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
                                    .foregroundColor(.primary.opacity(0.7))
                            }
                        }
                    }
                    .padding()
                    .padding(.top, -20)
                    
                    // Add to playlist
                    Button(action: {
                        allPlaylists = CoreDataManager.shared.fetchPlaylists()
                        showBottomSheet = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add to Playlist")
                                .bold()
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    }
                    .sheet(isPresented: $showBottomSheet) {
                        PlaylistSelectionSheet(playlists: allPlaylists, songToAdd: song) {
                            showBottomSheet = false
                        }
                    }
                    
                    // Save locally
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
                    
                    // View playlist
                    NavigationLink(destination: UserPlaylistView()) {
                        Text("View My Playlist")
                            .foregroundColor(.green)
                            .padding()
                            .background(Color.primary.opacity(0.1))
                            .cornerRadius(12)
                    }
                    
                    Spacer()
                }
                .padding()
                .onAppear {
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

    // MARK: - Helpers
    
    func shareSong(_ song: Song) {
        var items: [Any] = []
        let text = "Check out this song: \(song.title) by \(song.artist)"
        items.append(text)
        
        let fileManager = FileManager.default
        let docsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let songURL = docsURL.appendingPathComponent("\(song.fileName).mp3")
        
        if fileManager.fileExists(atPath: songURL.path) {
            items.append(songURL)
        }
        
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true, completion: nil)
        }
    }

    func saveSongLocally(_ song: Song) {
        let fileManager = FileManager.default
        guard let sourceURL = Bundle.main.url(forResource: song.fileName, withExtension: "mp3") else {
            print("❌ File not found in bundle: \(song.fileName).mp3")
            return
        }

        let docsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationURL = docsURL.appendingPathComponent("\(song.fileName).mp3")

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
