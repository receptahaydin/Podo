//
//  HomeViewController.swift
//  PO-DO
//
//  Created by Recep Taha Aydın on 29.12.2023.
//

import UIKit
import SRCountdownTimer

class HomeViewController: UIViewController {
    
    @IBOutlet weak var timer: SRCountdownTimer!
    @IBOutlet weak var bigButton: RoundedButton!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskSession: UILabel!
    @IBOutlet weak var taskMinute: UILabel!
    @IBOutlet weak var timerLabel: UILabel! {
        didSet {
            timerLabel.font = timerLabel.font.monospacedDigitFont
        }
    }
    
    let greenColor = UIColor.init(hexString: "55AA67")
    let img = ImageManager()
    var selectedTask: Task? {
        didSet {
            if let task = selectedTask {
                taskTitle.text = task.title
                taskMinute.text = "\(task.sessionDuration) minutes"
                taskSession.text = "\(task.completedSessionCount)/\(task.sessionCount)"
                setRoadMap()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if SoundManager.shared.soundType == 0 {
            soundButton.setTitle(" Fireplace", for: .normal)
        } else if SoundManager.shared.soundType == 1 {
            soundButton.setTitle(" Rain", for: .normal)
        } else if SoundManager.shared.soundType == 2 {
            soundButton.setTitle(" Nature", for: .normal)
        } else if SoundManager.shared.soundType == 3 {
            soundButton.setTitle(" Clock", for: .normal)
        } else if SoundManager.shared.soundType == 4 {
            soundButton.setTitle(" Jazz", for: .normal)
        } else if SoundManager.shared.soundType == 5 {
            soundButton.setTitle(" Piano", for: .normal)
        } else if SoundManager.shared.soundType == 6 {
            soundButton.setTitle(" Relax", for: .normal)
        } else {
            soundButton.setTitle(" No sound", for: .normal)
        }
    }
    
    private func setupTimer() {
        timer.lineWidth = 15.0
        timer.lineColor = UIColor.lightGray.withAlphaComponent(0.5)
        timer.trailLineColor = UIColor.init(hexString: "55AA67")
        timer.isLabelHidden = false
        timer.delegate = self
    }
    
    private func setRoadMap() {
        var roadMap: [String] = []
        
        if let sessionCount = selectedTask?.sessionCount {
            for i in 0..<(sessionCount * 2) - 1 {
                if i % 2 == 0 {
                    roadMap.append("T")
                } else if i == 7 || i == 15 {
                    roadMap.append("L")
                } else {
                    roadMap.append("S")
                }
            }
        }
        
        print(roadMap)
    }
    
    @IBAction func bigButtonAction(_ sender: Any) {
        if bigButton.backgroundColor == greenColor {
            bigButton.backgroundColor = UIColor.podoRed
            bigButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            timer.resume()
        } else {
            bigButton.backgroundColor = greenColor
            bigButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            timer.pause()
        }
    }
    
    @IBAction func refreshButtonAction(_ sender: Any) {
        timer.start(beginingValue: 15, interval: 1)
        
        if bigButton.isEnabled != true {
            bigButton.isEnabled = true
        }
        
        if bigButton.backgroundColor == greenColor {
            bigButton.backgroundColor = UIColor.podoRed
            bigButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        timer.reset()
        bigButton.isEnabled = false
        
        if bigButton.backgroundColor != greenColor {
            bigButton.backgroundColor = greenColor
            bigButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    @IBAction func soundButtonAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "homeToSound", sender: nil)
    }
}

extension HomeViewController: SRCountdownTimerDelegate {
    func timerDidUpdateCounterValue(sender: SRCountdownTimer, newValue: Int) {
        if timer.useMinutesAndSecondsRepresentation {
            timerLabel.text = timer.getMinutesAndSeconds(remainingSeconds: newValue)
        } else {
            timerLabel.text = "\(newValue)"
        }
    }
    
    func timerDidEnd(sender: SRCountdownTimer, elapsedTime: TimeInterval) {
        
    }
}

extension UIFont {
    var monospacedDigitFont: UIFont {
        let newFontDescriptor = fontDescriptor.monospacedDigitFontDescriptor
        return UIFont(descriptor: newFontDescriptor, size: 0)
    }
}

private extension UIFontDescriptor {
    var monospacedDigitFontDescriptor: UIFontDescriptor {
        let fontDescriptorFeatureSettings = [[UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
                                              UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector]]
        let fontDescriptorAttributes = [UIFontDescriptor.AttributeName.featureSettings: fontDescriptorFeatureSettings]
        let fontDescriptor = self.addingAttributes(fontDescriptorAttributes)
        return fontDescriptor
    }
}
