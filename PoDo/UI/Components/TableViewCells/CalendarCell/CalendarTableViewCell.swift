//
//  CalendarTableViewCell.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 13.03.2024.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taskIcon: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var checkIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    public func configureCell(task: Task) {
        self.titleLabel.text = task.title
        self.dateLabel.text = task.date
        self.descLabel.text = task.description
        
        if task.status == 2 {
            dateLabel.isHidden = true
            checkIcon.isHidden = false
        } else {
            dateLabel.isHidden = false
            checkIcon.isHidden = true
        }
    }
}
