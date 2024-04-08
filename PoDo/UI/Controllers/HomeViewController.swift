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
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskSession: UILabel!
    @IBOutlet weak var taskMinute: UILabel!
    @IBOutlet weak var taskIcon: UIImageView!
    @IBOutlet weak var startPodoButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel! {
        didSet {
            timerLabel.font = timerLabel.font.monospacedDigitFont
        }
    }
    
    let img = ImageManager()
    var selectedTask: Task?
    var roadMap: [String] = []
    
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
    
    func setRoadMap() {
        bigButton.backgroundColor = UIColor.podoRed
        bigButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        
        taskTitle.text = selectedTask!.title
        taskMinute.text = "\(selectedTask!.sessionDuration) minutes"
        taskSession.text = "\(selectedTask!.completedSessionCount)/\(selectedTask!.sessionCount)"
        startPodoButton.isHidden = true
        cardView.isHidden = false
        roadMap = []
        
        for i in 0..<(selectedTask!.sessionCount * 2) - 1 {
            if i % 2 == 0 {
                roadMap.append("T")
            } else if i % 8 == 7 {
                roadMap.append("L")
            } else {
                roadMap.append("S")
            }
        }
        
        for i in 0..<(selectedTask!.completedSessionCount * 2) {
            roadMap[i] = "F"
        }
        
        timerSessionControl()
    }
    
    private func timerSessionControl() {
        for i in 0..<roadMap.count {
            if roadMap[i] == "T" {
                taskTitle.text = selectedTask!.title
                taskMinute.text = "\(selectedTask!.sessionDuration) minutes"
                taskSession.text = "\(selectedTask!.completedSessionCount)/\(selectedTask!.sessionCount)"
                taskIcon.image = UIImage(named: "green")
                timer.start(beginingValue: 10)
                break
            } else if roadMap[i] == "S" {
                taskTitle.text = "Short Break"
                taskMinute.text = "\(selectedTask!.shortBreakDuration) minutes"
                taskSession.text = "\(selectedTask!.completedSessionCount)/\(selectedTask!.sessionCount)"
                taskIcon.image = UIImage(named: "break")
                timer.start(beginingValue: 3)
                break
            } else if roadMap[i] == "L" {
                taskTitle.text = "Long Break"
                taskMinute.text = "\(selectedTask!.longBreakDuration) minutes"
                taskSession.text = "\(selectedTask!.completedSessionCount)/\(selectedTask!.sessionCount)"
                taskIcon.image = UIImage(named: "break")
                timer.start(beginingValue: 5)
                break
            }
        }
    }
    
    @IBAction func bigButtonAction(_ sender: Any) {
        if bigButton.backgroundColor == UIColor.PODOGreen {
            bigButton.backgroundColor = UIColor.podoRed
            bigButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            timer.resume()
        } else {
            bigButton.backgroundColor = UIColor.PODOGreen
            bigButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            timer.pause()
        }
    }
    
    @IBAction func refreshButtonAction(_ sender: Any) {
        let timeString = taskMinute.text ?? ""
        let components = timeString.components(separatedBy: " ")
        if let intValue = Int(components.first ?? "") {
            timer.start(beginingValue: intValue * 60)
            if bigButton.isEnabled != true {
                bigButton.isEnabled = true
            }
            
            if bigButton.backgroundColor == UIColor.PODOGreen {
                bigButton.backgroundColor = UIColor.podoRed
                bigButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            }
        }
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        timer.reset()
        bigButton.isEnabled = false
        
        if bigButton.backgroundColor != UIColor.PODOGreen {
            bigButton.backgroundColor = UIColor.PODOGreen
            bigButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    @IBAction func startPodoButtonAction(_ sender: Any) {
        if let tabBarController = self.tabBarController,
           let tasksNavVC = tabBarController.viewControllers?[1] as? UINavigationController,
           let taskVC = tasksNavVC.viewControllers.first as? TasksViewController {
            tabBarController.selectedIndex = 1
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
        for i in 0..<roadMap.count {
            if roadMap[i] != "F" {
                if roadMap[i] == "T" {
                    selectedTask?.completedSessionCount += 1
                    FirestoreManager().incrementCompletedSessionCount(taskID: selectedTask!.id) { error in
                        if let error = error {
                            print("Error incrementing completedSessionCount: \(error.localizedDescription)")
                        } else {
                            print("completedSessionCount incremented successfully.")
                        }
                    }
                }
                
                if i == 0 {
                    FirestoreManager().updateTaskStatus(taskID: selectedTask!.id, newStatus: 1) { error in
                        if let error = error {
                            print("Error updating task status: \(error.localizedDescription)")
                        } else {
                            print("Task status updated successfully.")
                        }
                    }
                } else if i == roadMap.count - 1 {
                    FirestoreManager().updateTaskStatus(taskID: selectedTask!.id, newStatus: 2) { error in
                        if let error = error {
                            print("Error updating task status: \(error.localizedDescription)")
                        } else {
                            print("Task status updated successfully.")
                        }
                    }
                    taskSession.text = "\(selectedTask!.completedSessionCount)/\(selectedTask!.sessionCount)"
                }
                roadMap[i] = "F"
                break
            }
        }
        timerSessionControl()
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
