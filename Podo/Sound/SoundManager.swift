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
    private var backgroundMusicPlayer: AVAudioPlayer?
    var soundType: Int = -1
    
    private init() {}
    
    func playSound(named name: String, withExtension ext: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            if name == "ding" {
                player = try AVAudioPlayer(contentsOf: url)
                player?.numberOfLoops = 0
                player?.play()
                return
            }
            
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1
            backgroundMusicPlayer?.play()
            
            switch name {
            case "fireplace": soundType = 0
            case "rain": soundType = 1
            case "nature": soundType = 2
            case "clock": soundType = 3
            case "jazz": soundType = 4
            case "piano": soundType = 5
            case "relax": soundType = 6
            default: break
            }
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        backgroundMusicPlayer?.stop()
        soundType = -1
    }
}
