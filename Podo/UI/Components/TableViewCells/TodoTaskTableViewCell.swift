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
    var itemID: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        taskName.attributedText = nil
        completedButton.setImage(UIImage(systemName: "square"), for: .normal)
        favouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    public func configureCell(item: ListItem) {
        itemID = item.id
        taskName.text = item.title
        
        configureFavouriteState(isFavourite: item.isFavourite)
        configureCompletedState(isCompleted: item.isCompleted)
    }
    
    private func configureCompletedState(isCompleted: Bool) {
        self.isCompleted = isCompleted
        let imageName = isCompleted ? "checkmark.square.fill" : "square"
        completedButton.setImage(UIImage(systemName: imageName), for: .normal)
        
        taskName.attributedText = NSAttributedString(
            string: taskName.text ?? "",
            attributes: isCompleted ? [.strikethroughStyle: NSUnderlineStyle.single.rawValue] : [:]
        )
        
        updateItemState(isCompleted: isCompleted)
    }

    private func updateItemState(isCompleted: Bool) {
        if let index = ItemManager.shared.items.firstIndex(where: { $0.id == self.itemID }) {
            ItemManager.shared.items[index].isCompleted = isCompleted
        }
    }

    private func configureFavouriteState(isFavourite: Bool) {
        self.isFavourite = isFavourite
        let imageName = isFavourite ? "star.fill" : "star"
        favouriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        
        updateFavouriteState(isFavourite: isFavourite)
    }
    
    private func updateFavouriteState(isFavourite: Bool) {
        if let index = ItemManager.shared.items.firstIndex(where: { $0.id == self.itemID }) {
            ItemManager.shared.items[index].isFavourite = isFavourite
        }
    }
    
    @IBAction func completedButtonAction(_ sender: UIButton) {
        isCompleted.toggle()
        configureCompletedState(isCompleted: isCompleted)
        
        guard let itemID = itemID else { return }
        
        FirestoreManager().updateCompletedState(itemID: itemID, isCompleted: isCompleted) { error in
            if let error = error {
                print("Error updating item state: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func favoruiteButtonAction(_ sender: UIButton) {
        isFavourite.toggle()
        configureFavouriteState(isFavourite: isFavourite)
        
        guard let itemID = itemID else { return }
        
        FirestoreManager().updateFavouriteState(itemID: itemID, isFavourite: isFavourite) { error in
            if let error = error {
                print("Error updating item favourite: \(error.localizedDescription)")
            }
        }
    }
}
