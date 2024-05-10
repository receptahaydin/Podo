//
//  NewItemViewController.swift
//  Podo
//
//  Created by Recep Taha Aydın on 9.05.2024.
//

import UIKit

class NewItemViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var listID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = "Please enter an item name"
        textView.textColor = UIColor.lightGray
    }
    
    @IBAction func favouriteButtonClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected {
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    @IBAction func doneButtonClicked(_ sender: UIButton) {
        guard let itemName = textView.text, !itemName.isEmpty, itemName != "Please enter an item name" else {
            return
        }
        
        let isFavourite = favouriteButton.isSelected
        
        let itemData: [String: Any] = [
            "isFavourite": isFavourite,
            "listId": listID!,
            "title": itemName
        ]
        
        let item = ListItem(data: itemData)
        FirestoreManager().addListItem(item: item)
        //delegate?.didCreateList(list: list)
        dismiss(animated: true, completion: nil)
    }
}

extension NewItemViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Please enter an item name"
            textView.textColor = UIColor.lightGray
        }
    }
}
