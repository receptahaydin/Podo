//
//  TaskTableViewCell.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 16.02.2024.
//

import UIKit

class UncompletedTaskCell: UITableViewCell {
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taskIcon: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var playButton: RoundedButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moreButton.transform = CGAffineTransformMakeRotation(CGFloat(Double.pi / 2))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configureCell(task: Task) {
        self.titleLabel.text = task.title
        self.dateLabel.text = task.date
        self.descLabel.text = task.description
    }
}
