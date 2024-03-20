//
//  ProfileTableViewCell.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 20.03.2024.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var imageButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageButton.cornerRadius = imageButton.frame.height / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
