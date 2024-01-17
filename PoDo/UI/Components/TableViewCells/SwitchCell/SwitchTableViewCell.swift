//
//  SwitchTableViewCell.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 18.01.2024.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateSwitchAppearance()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(image: UIImage, title: String) {
        icon.image = image
        label.text = title
        updateSwitchAppearance()
    }
    
    private func updateSwitchAppearance() {
        if #available(iOS 13.0, *) {
            let currentStyle = traitCollection.userInterfaceStyle
            if currentStyle == .dark {
                `switch`.isOn = true
            } else {
                `switch`.isOn = false
            }
        } else {
            `switch`.isOn = false
        }
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        if `switch`.isOn {
              applyDarkTheme()
          } else {
              applyLightTheme()
          }
      }

      private func applyDarkTheme() {
          if #available(iOS 13.0, *) {
              UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .dark
          }
      }

      private func applyLightTheme() {
          if #available(iOS 13.0, *) {
              UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
          }
      }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateSwitchAppearance()
    }
}
