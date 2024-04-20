//
//  CollectionViewCell.swift
//  Podo
//
//  Created by Recep Taha Aydın on 20.04.2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var listName: UILabel!
    
    func configure(name: String) {
        listName.text = name
    }
}
