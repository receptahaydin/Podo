//
//  TodoTaskTableViewCell.swift
//  Podo
//
//  Created by Recep Taha Aydın on 8.05.2024.
//

import UIKit

class TodoTaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var isCompleted = false
    var isFavourite = false
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func completedButtonAction(_ sender: UIButton) {
        if isCompleted {
            completedButton.setImage(UIImage(systemName: "square"), for: .normal)
            
            let attributedText = NSAttributedString(
                string: taskName.text!,
                attributes: [:]
            )
            taskName.attributedText = attributedText
            
            isCompleted = false
        } else {
            completedButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            
            let attributedText = NSAttributedString(
                string: taskName.text!,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            taskName.attributedText = attributedText
            
            isCompleted = true
        }
    }
    
    @IBAction func favoruiteButtonAction(_ sender: UIButton) {
        if isFavourite {
            favouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            isFavourite = false
        } else {
            favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            isFavourite = true
        }
    }
}
