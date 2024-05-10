//
//  ItemManager.swift
//  Podo
//
//  Created by Recep Taha Aydın on 10.05.2024.
//

import Foundation

class ItemManager {
    static let shared = ItemManager()
    
    var items: [ListItem] = []
    
    private init() {}
}
