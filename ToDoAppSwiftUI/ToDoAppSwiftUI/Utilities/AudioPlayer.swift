//
//  AudioPlayer.swift
//  ToDoAppSwiftUI
//
//  Created by Hamza Azhar on 04/05/2022.
//

import Foundation
import AVFoundation

class AudioPlayer {
    static let shared = AudioPlayer()
    
    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                let audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } 
        }
    }
}


