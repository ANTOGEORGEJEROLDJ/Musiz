//
//  SongModel.swift
//  Musiz
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import Foundation
// MARK: - Song Model

struct Song: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let imageName: String
    let fileName: String
    let genre: String   // <-- Make sure this is present
}


// MARK: - Sample Data

let recommendedSongs = [
    Song(title: "Peaches", artist: "Justin Bieber", imageName: "11", fileName: "Peaches", genre: "Pop"),
    Song(title: "Ghost", artist: "Justin Bieber", imageName: "12", fileName: "ghost", genre: "Pop"),
    Song(title: "Love Yourself", artist: "Justin Bieber", imageName: "13", fileName: "love_yourself", genre: "Pop"),
    Song(title: "Sorry", artist: "Justin Bieber", imageName: "14", fileName: "sorry", genre: "Pop"),
    Song(title: "What Do You Mean?", artist: "Justin Bieber", imageName: "15", fileName: "what_do_you_mean", genre: "Pop"),
    Song(title: "Baby", artist: "Justin Bieber", imageName: "16", fileName: "baby", genre: "Pop"),
    Song(title: "Intentions", artist: "Justin Bieber", imageName: "17", fileName: "intentions", genre: "Pop"),
    Song(title: "Yummy", artist: "Justin Bieber", imageName: "18", fileName: "yummy", genre: "Pop"),
    Song(title: "Hold On", artist: "Justin Bieber", imageName: "19", fileName: "hold_on", genre: "Pop"),
    Song(title: "Anyone", artist: "Justin Bieber", imageName: "20", fileName: "anyone", genre: "Pop"),
    Song(title: "Never Say Never", artist: "Justin Bieber", imageName: "21", fileName: "never_say_never", genre: "Pop"),
    Song(title: "Company", artist: "Justin Bieber", imageName: "22", fileName: "company", genre: "Pop")
]



let topMixes = [
    Song(title: "Perfect", artist: "Ed Sheeran", imageName: "23", fileName: "Perfect", genre: "Acoustic"),
    Song(title: "Shape of You", artist: "Ed Sheeran", imageName: "24", fileName: "shape_of_you", genre: "Acoustic"),
    Song(title: "Thinking Out Loud", artist: "Ed Sheeran", imageName: "25", fileName: "thinking_out_loud", genre: "Acoustic"),
    Song(title: "Photograph", artist: "Ed Sheeran", imageName: "26", fileName: "photograph", genre: "Acoustic"),
    Song(title: "Bad Habits", artist: "Ed Sheeran", imageName: "27", fileName: "bad_habits", genre: "Acoustic"),
    Song(title: "Shivers", artist: "Ed Sheeran", imageName: "28", fileName: "shivers", genre: "Acoustic"),
    Song(title: "Castle on the Hill", artist: "Ed Sheeran", imageName: "29", fileName: "castle_on_the_hill", genre: "Acoustic"),
    Song(title: "Afterglow", artist: "Ed Sheeran", imageName: "30", fileName: "afterglow", genre: "Acoustic"),
    Song(title: "Eyes Closed", artist: "Ed Sheeran", imageName: "31", fileName: "eyes_closed", genre: "Acoustic"),
    Song(title: "Galway Girl", artist: "Ed Sheeran", imageName: "32", fileName: "galway_girl", genre: "Acoustic"),
    Song(title: "Dive", artist: "Ed Sheeran", imageName: "33", fileName: "dive", genre: "Acoustic"),
    Song(title: "Happier", artist: "Ed Sheeran", imageName: "34", fileName: "happier", genre: "Acoustic")
]


let moodBooster = [
    Song(title: "Happy Now", artist: "Zedd", imageName: "2", fileName: "happy_now", genre: "Chill"),
    Song(title: "Sunshine", artist: "OneRepublic", imageName: "3", fileName: "sunshine", genre: "Chill"),
    Song(title: "Elevate", artist: "Drake", imageName: "4", fileName: "elevate", genre: "Chill"),
    Song(title: "Good Vibes", artist: "Khalid", imageName: "5", fileName: "good_vibes", genre: "Chill"),
    Song(title: "Feel Alive", artist: "Lost Frequencies", imageName: "6", fileName: "feel_alive", genre: "Chill"),
    Song(title: "Bright Side", artist: "Imagine Dragons", imageName: "7", fileName: "bright_side", genre: "Chill"),
    Song(title: "On Top", artist: "Calvin Harris", imageName: "8", fileName: "on_top", genre: "Chill"),
    Song(title: "Shine", artist: "Lizzo", imageName: "9", fileName: "shine", genre: "Chill"),
    Song(title: "Celebrate", artist: "Pitbull", imageName: "10", fileName: "celebrate", genre: "Chill"),
    Song(title: "Rise Up", artist: "Andra Day", imageName: "11", fileName: "rise_up", genre: "Chill"),
    Song(title: "Jumpstart", artist: "Sia", imageName: "12", fileName: "jumpstart", genre: "Chill"),
    Song(title: "Bright Lights", artist: "Ellie Goulding", imageName: "1", fileName: "bright_lights", genre: "Chill")
]


