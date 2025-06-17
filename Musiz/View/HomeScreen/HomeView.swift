//
//  HomeView.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI
import AVFoundation


struct HomeView: View {
    @StateObject private var audioVM = AudioPlayerViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Good Afternoon")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.top, 16)
                    
                    SectionView(title: "Recommended", songs: recommendedSongs, audioVM: audioVM)
                    SectionView(title: "Your Top Mixes", songs: topMixes, audioVM: audioVM)
                    SectionView(title: "Mood Booster", songs: moodBooster, audioVM: audioVM)
                    
                    Spacer(minLength: 30)
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
    }
}



