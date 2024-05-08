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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func completedButtonAction(_ sender: UIButton) {
            // Check if the button's current image is square or square.fill
            if sender.currentImage == UIImage(named: "square") {
                // Change the button image to square.fill
                sender.setImage(UIImage(named: "square.fill"), for: .normal)
                
                // Apply strikethrough style to the task name label
                let attributedText = NSAttributedString(
                    string: taskName.text!,
                    attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
                )
                taskName.attributedText = attributedText
            } else if sender.currentImage == UIImage(named: "square.fill") {
                // Change the button image to square
                sender.setImage(UIImage(named: "square"), for: .normal)
                
                // Remove strikethrough style from the task name label
                let attributedText = NSAttributedString(
                    string: taskName.text!,
                    attributes: [:]
                )
                taskName.attributedText = attributedText
            }
        

    }
    
    
    @IBAction func favoruiteButtonAction(_ sender: UIButton) {
        
    }
}
