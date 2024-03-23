//
//  SoundManager.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 23.03.2024.
//

import Foundation
import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    
    private var player: AVAudioPlayer?
    var soundType: Int = -1
    
    private init() {}
    
    func playSound(named name: String, withExtension ext: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.play()
            
            if name == "fireplace" {
                soundType = 0
            } else if name == "rain" {
                soundType = 1
            } else if name == "nature" {
                soundType = 2
            }
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        player?.stop()
        soundType = -1
    }
}
