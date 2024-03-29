//
//  SoundsViewController.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 23.03.2024.
//

import UIKit

class SoundsViewController: UIViewController {
    
    @IBOutlet weak var noSoundButton: UIButton!
    @IBOutlet weak var fireplaceButton: UIButton!
    @IBOutlet weak var rainButton: UIButton!
    @IBOutlet weak var natureButton: UIButton!
    @IBOutlet weak var clockButton: UIButton!
    @IBOutlet weak var jazzButton: UIButton!
    @IBOutlet weak var pianoButton: UIButton!
    @IBOutlet weak var relaxButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCardColors()
    }
    
    private func setCardColors() {
        if SoundManager.shared.soundType == 0 {
            fireplaceButton.backgroundColor = .podoRed
        } else if SoundManager.shared.soundType == 1 {
            rainButton.backgroundColor = .podoRed
        } else if SoundManager.shared.soundType == 2 {
            natureButton.backgroundColor = .podoRed
        } else if SoundManager.shared.soundType == 3 {
            clockButton.backgroundColor = .podoRed
        } else if SoundManager.shared.soundType == 4 {
            jazzButton.backgroundColor = .podoRed
        } else if SoundManager.shared.soundType == 5 {
            pianoButton.backgroundColor = .podoRed
        } else if SoundManager.shared.soundType == 6 {
            relaxButton.backgroundColor = .podoRed
        } else {
            noSoundButton.backgroundColor = .podoRed
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        noSoundButton.backgroundColor = .music
        fireplaceButton.backgroundColor = .music
        rainButton.backgroundColor = .music
        natureButton.backgroundColor = .music
        clockButton.backgroundColor = .music
        jazzButton.backgroundColor = .music
        pianoButton.backgroundColor = .music
        relaxButton.backgroundColor = .music
        
        sender.backgroundColor = .podoRed
        
        if sender == noSoundButton {
            SoundManager.shared.stopSound()
        } else if sender == fireplaceButton {
            SoundManager.shared.playSound(named: "fireplace", withExtension: "mp3")
        } else if sender == rainButton {
            SoundManager.shared.playSound(named: "rain", withExtension: "mp3")
        } else if sender == natureButton {
            SoundManager.shared.playSound(named: "nature", withExtension: "mp3")
        } else if sender == clockButton {
            SoundManager.shared.playSound(named: "clock", withExtension: "mp3")
        } else if sender == jazzButton {
            SoundManager.shared.playSound(named: "jazz", withExtension: "mp3")
        } else if sender == pianoButton {
            SoundManager.shared.playSound(named: "piano", withExtension: "mp3")
        } else if sender == relaxButton {
            SoundManager.shared.playSound(named: "relax", withExtension: "mp3")
        }
    }
}
