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
    @IBOutlet weak var timerLabel: UILabel! {
        didSet {
            timerLabel.font = timerLabel.font.monospacedDigitFont
        }
    }
    
    let greenColor = UIColor.init(hexString: "55AA67")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimer()
    }
    
    private func setupTimer() {
        timer.lineWidth = 20.0
        timer.lineColor = UIColor.lightGray.withAlphaComponent(0.5)
        timer.trailLineColor = UIColor.init(hexString: "55AA67")
        timer.isLabelHidden = false
        timer.delegate = self
        timer.start(beginingValue: 1500, interval: 1)
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
}

extension HomeViewController: SRCountdownTimerDelegate {
    func timerDidUpdateCounterValue(sender: SRCountdownTimer, newValue: Int) {
           if timer.useMinutesAndSecondsRepresentation {
               timerLabel.text = timer.getMinutesAndSeconds(remainingSeconds: newValue)
           } else {
               timerLabel.text = "\(newValue)"
           }
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
