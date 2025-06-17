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
    @State private var profileImage: UIImage?
    @State private var user: User?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    HStack{
                        Text("Good Afternoon")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.top, 16)
                        
                        NavigationLink(destination: ProfileView()) {
                            if let image = profileImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 45, height: 45)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.green, lineWidth: 2))
                                    .padding(.top, 16)
                                    .padding(.leading, 20)
                            } else {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.gray)
                                    .padding(.top, 16)
                                    .padding(.leading, 20)
                            }
                            
                        }
                        
                        
                    }
                    
                    SectionView(title: "Recommended", songs: recommendedSongs, audioVM: audioVM)
                    SectionView(title: "Your Top Mixes", songs: topMixes, audioVM: audioVM)
                    SectionView(title: "Mood Booster", songs: moodBooster, audioVM: audioVM)
                    
                    Spacer(minLength: 30)
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
            .onAppear {
                user = CoreDataManager.shared.fetchLatestUser()
                if let data = user?.profileImage, let uiImage = UIImage(data: data) {
                    profileImage = uiImage
                }
            }
        }
    }
}



