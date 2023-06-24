//
//  Meows.swift
//  Totally Cats
//
//  Created by Jon Salkin on 6/23/23.
//

import Foundation
import AVFoundation
import SwiftUI
import AVFAudio

class MeowsManager: ObservableObject {
    @Published var audioPlayer: AVAudioPlayer?
    
    var meow1: URL {
        guard let url = Bundle.main.url(forResource: "meow1", withExtension: "mp3") else {
            fatalError("Failed to find meow1.mp3 in the main bundle")
        }
        return url
    }
    
    var meow2: URL {
        guard let url = Bundle.main.url(forResource: "meow2", withExtension: "mp3") else {
            fatalError("Failed to find meow2.mp3 in the main bundle")
        }
        return url
    }
    
    var meow3: URL {
        guard let url = Bundle.main.url(forResource: "meow3", withExtension: "mp3") else {
            fatalError("Failed to find meow3.mp3 in the main bundle")
        }
        return url
    }
    
    var meow4: URL {
        guard let url = Bundle.main.url(forResource: "meow4", withExtension: "mp3") else {
            fatalError("Failed to find meow4.mp3 in the main bundle")
        }
        return url
    }
    
    var meow5: URL {
        guard let url = Bundle.main.url(forResource: "meow5", withExtension: "mp3") else {
            fatalError("Failed to find meow5.mp3 in the main bundle")
        }
        return url
    }
    
    var meow6: URL {
        guard let url = Bundle.main.url(forResource: "meow6", withExtension: "mp3") else {
            fatalError("Failed to find meow6.mp3 in the main bundle")
        }
        return url
    }
    
    var meow7: URL {
        guard let url = Bundle.main.url(forResource: "meow7", withExtension: "mp3") else {
            fatalError("Failed to find meow7.mp3 in the main bundle")
        }
        return url
    }

    
    func playMeow() {
        let meows: [String] = ["meow1", "meow2", "meow3", "meow4", "meow5", "meow6", "meow7"]
        let randomIndex = Int.random(in: 0..<meows.count)
        let meowName = meows[randomIndex]

        guard let meowURL = Bundle.main.url(forResource: meowName, withExtension: "mp3") else {
            print("Failed to find \(meowName).mp3 in the main bundle")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: meowURL)
            audioPlayer?.play()
        } catch {
            print("Failed to play meow sound: \(error)")
        }
    }
}

struct MeowsView: View {
    @ObservedObject var meowsManager = MeowsManager()
    
    var body: some View {
        Text("")
    }
    
    func playMeow() {
        meowsManager.playMeow()
    }
}

struct MeowsView_Previews: PreviewProvider {
    static var previews: some View {
        MeowsView()
    }
}
