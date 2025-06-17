//
//  SleepTimerManager.swift
//  Musiz
//

import Foundation
import AVFoundation

class SleepTimerManager: ObservableObject {
    static let shared = SleepTimerManager()
    
    private var timer: Timer?
    private var duration: TimeInterval = 0
    private var endDate: Date?
    
    @Published var remainingTime: TimeInterval = 0
    @Published var isTimerActive = false
    
    private init() {}

    func startTimer(minutes: Int, player: AVAudioPlayer?) {
        timer?.invalidate()
        duration = TimeInterval(minutes * 60)
        endDate = Date().addingTimeInterval(duration)
        isTimerActive = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateCountdown(player: player)
        }
    }
    
    func cancelTimer() {
        timer?.invalidate()
        isTimerActive = false
        remainingTime = 0
    }
    
    private func updateCountdown(player: AVAudioPlayer?) {
        guard let endDate = endDate else { return }
        remainingTime = endDate.timeIntervalSinceNow
        
        if remainingTime <= 0 {
            timer?.invalidate()
            isTimerActive = false
            player?.stop()
            print("🛏️ Sleep Timer ended - Stopped playback")
        }
    }
}
