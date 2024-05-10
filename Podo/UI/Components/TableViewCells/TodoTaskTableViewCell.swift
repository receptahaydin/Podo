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
    
    public func configureCell(item: ListItem) {
        taskName.text = item.title
        
        if item.isFavourite {
            favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        if item.isCompleted {
            completedButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            
            taskName.attributedText = NSAttributedString(
                string: taskName.text!,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
        } else {
            completedButton.setImage(UIImage(systemName: "square"), for: .normal)
            
            taskName.attributedText = NSAttributedString(
                string: taskName.text!,
                attributes: [:]
            )
        }
    }
    
    @IBAction func completedButtonAction(_ sender: UIButton) {
        isCompleted.toggle()
        if isCompleted {
            completedButton.setImage(UIImage(systemName: "square"), for: .normal)
            
            taskName.attributedText = NSAttributedString(
                string: taskName.text!,
                attributes: [:]
            )
        } else {
            completedButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            
            taskName.attributedText = NSAttributedString(
                string: taskName.text!,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
        }
    }
    
    @IBAction func favoruiteButtonAction(_ sender: UIButton) {
        isFavourite.toggle()
        if isFavourite {
            favouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
    }
}
