//
//  TaskTableViewCell.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 16.02.2024.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var moreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moreButton.transform = CGAffineTransformMakeRotation(CGFloat(Double.pi / 2)) 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
