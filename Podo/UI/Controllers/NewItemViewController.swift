//
//  NewItemViewController.swift
//  Podo
//
//  Created by Recep Taha Aydın on 9.05.2024.
//

import UIKit

protocol NewTodoDelegate: AnyObject {
    func didCreateItem(item: ListItem)
    func didCreateList(list: List)
}

enum PageType {
    case addList
    case addItem
}

class NewItemViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    weak var delegate: NewTodoDelegate?
    var pageType: PageType?
    var listID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        switch pageType {
        case .addList:
            favouriteButton.isHidden = true
            textView.text = "Please enter a list name"
            titleLabel.text = "Create New List"
        case .addItem:
            favouriteButton.isHidden = false
            textView.text = "Please enter an item name"
            titleLabel.text = "Create New Item"
        case .none:
            return
        }
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
        guard let itemName = textView.text,
              !itemName.isEmpty,
              itemName != "Please enter an item name",
              itemName != "Please enter a list name" else {
            return
        }
        
        switch pageType {
        case .addList:
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
            let dateString = dateFormatter.string(from: currentDate)
            
            let listData: [String: Any] = [
                "createdDate": dateString,
                "title": itemName
            ]
            
            let list = List(data: listData)
            FirestoreManager().addList(list: list)
            delegate?.didCreateList(list: list)
        case .addItem:
            let isFavourite = favouriteButton.isSelected
            
            let itemData: [String: Any] = [
                "isFavourite": isFavourite,
                "listId": listID!,
                "title": itemName
            ]
            
            let item = ListItem(data: itemData)
            FirestoreManager().addListItem(item: item)
            delegate?.didCreateItem(item: item)
        case .none:
            return
        }
        
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
            switch pageType {
            case .addList:
                textView.text = "Please enter a list name"
            case .addItem:
                textView.text = "Please enter an item name"
            case .none:
                return
            }
            textView.textColor = UIColor.lightGray
        }
    }
}
