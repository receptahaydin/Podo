//
//  NewItemViewController.swift
//  Podo
//
//  Created by Recep Taha Aydın on 9.05.2024.
//

import UIKit

class NewItemViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var listID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = "Please enter an item name"
        textView.textColor = UIColor.lightGray
    }
    
    @IBAction func favouriteButtonClicked(_ sender: UIButton) {
    }
    
    @IBAction func doneButtonClicked(_ sender: UIButton) {
        guard let listName = textView.text, !listName.isEmpty, listName != "Please enter an item name" else {
            return
        }
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
