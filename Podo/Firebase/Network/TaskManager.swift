//
//  TaskManager.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 29.02.2024.
//

import Foundation

class TaskManager {
    static let shared = TaskManager()
    
    var tasks: [Task] = []
    var filteredTasks: [Task] = []
    
    private init() {}
}
