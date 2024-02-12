//
//  TaskStruct.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 12.02.2024.
//

import Foundation

struct TaskModel: Codable {
    
    var title: String
    var description: String
    var createdDate: String
    var taskTime: String
    var category: String
    var status: Int
    var sessionCount: Int
    var completedSessionCount: Int

    // Custom initializer to convert from Firestore dictionary
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.createdDate = dictionary["createdDate"] as? String ?? ""
        self.taskTime = dictionary["taskTime"] as? String ?? ""
        self.category = dictionary["category"] as? String ?? ""
        self.status = dictionary["status"] as? Int ?? 0
        self.sessionCount = dictionary["sessionCount"] as? Int ?? 0
        self.completedSessionCount = dictionary["completedSessionCount"] as? Int ?? 0
    }

    // Custom computed property to convert to Firestore dictionary
    var dictionaryRepresentation: [String: Any] {
        return [
            "title": title,
            "description": description,
            "createdDate": createdDate,
            "taskTime": taskTime,
            "category": category,
            "status": status,
            "sessionCount": sessionCount,
            "completedSessionCount": completedSessionCount
        ]
    }
}

