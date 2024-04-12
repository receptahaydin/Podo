//
//  OptionTableViewCell.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 17.01.2024.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(image: UIImage, title: String) {
        if title == "Logout" {
            label.textColor = .PODORed
            icon.tintColor = .PODORed
        }
        
        icon.image = image
        label.text = title
    }
}
