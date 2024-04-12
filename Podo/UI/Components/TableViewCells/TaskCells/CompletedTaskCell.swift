//
//  CompletedTaskCell.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 15.03.2024.
//

import UIKit

class CompletedTaskCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
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
    }
}
