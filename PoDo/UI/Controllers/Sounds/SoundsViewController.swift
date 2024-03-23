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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        noSoundButton.backgroundColor = .music
        fireplaceButton.backgroundColor = .music
        rainButton.backgroundColor = .music
        natureButton.backgroundColor = .music
        
        sender.backgroundColor = .podoRed
        
        if sender == noSoundButton {
            SoundManager.shared.stopSound()
        } else if sender == fireplaceButton {
            SoundManager.shared.playSound(named: "fireplace", withExtension: "mp3")
        } else if sender == rainButton {
            SoundManager.shared.playSound(named: "rain", withExtension: "mp3")
        } else if sender == natureButton {
            SoundManager.shared.playSound(named: "nature", withExtension: "mp3")
        }
    }
}
