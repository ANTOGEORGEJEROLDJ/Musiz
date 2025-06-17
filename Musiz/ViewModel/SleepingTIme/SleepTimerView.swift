//
//  SleepTimerView.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI
import AVFoundation

struct SleepTimerView: View {
    @ObservedObject var timerManager = SleepTimerManager.shared
    @State private var customMinutes = ""
    @Environment(\.dismiss) var dismiss

    var player: AVAudioPlayer?

    var body: some View {
        VStack(spacing: 24) {
            Text("Set Sleep Timer")
                .font(.title)
                .foregroundColor(.white)

            HStack(spacing: 16) {
                ForEach([15, 30, 60], id: \.self) { minutes in
                    Button(action: {
                        timerManager.startTimer(minutes: minutes, player: player)
                        dismiss()
                    }) {
                        Text("\(minutes) min")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
            }

            HStack {
                TextField("Custom", text: $customMinutes)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 80)

                Button("Start") {
                    if let mins = Int(customMinutes), mins > 0 {
                        timerManager.startTimer(minutes: mins, player: player)
                        dismiss()
                    }
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            if timerManager.isTimerActive {
                Text("Time Left: \(formatTime(timerManager.remainingTime))")
                    .foregroundColor(.white)
            }

            Button("Cancel Timer") {
                timerManager.cancelTimer()
                dismiss()
            }
            .foregroundColor(.red)
        }
        .padding()
        .background(Color.black)
    }

    func formatTime(_ time: TimeInterval) -> String {
        let mins = Int(time) / 60
        let secs = Int(time) % 60
        return String(format: "%02d:%02d", mins, secs)
    }
}
