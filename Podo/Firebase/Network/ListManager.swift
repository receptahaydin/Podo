//
//  ListManager.swift
//  Podo
//
//  Created by Recep Taha Aydın on 9.05.2024.
//

import Foundation

class ListManager {
    static let shared = ListManager()
    
    var lists: [List] = []
    
    private init() {}
}
