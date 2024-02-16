//
//  TaskStruct.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 12.02.2024.
//

import Foundation

struct TaskModel: Codable {
    
    var id: String
    var title: String
    var description: String
    var date: String
    var time: String
    var category: String
    var status: Int // 0 = not started, 1 = in progress, 2 = completed
    var sessionCount: Int
    var completedSessionCount: Int
    var sessionDuration: Int
    var shortBreakDuration: Int
    var longBreakDuration: Int
    
    // Custom initializer to convert from Firestore dictionary
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.date = dictionary["createdDate"] as? String ?? ""
        self.time = dictionary["taskTime"] as? String ?? ""
        self.category = dictionary["category"] as? String ?? ""
        self.status = dictionary["status"] as? Int ?? 0
        self.sessionCount = dictionary["sessionCount"] as? Int ?? 0
        self.completedSessionCount = dictionary["completedSessionCount"] as? Int ?? 0
        self.sessionDuration = dictionary["sessionDuration"] as? Int ?? 0
        self.shortBreakDuration = dictionary["shortBreakDuration"] as? Int ?? 0
        self.longBreakDuration = dictionary["longBreakDuration"] as? Int ?? 0
    }

    // Custom computed property to convert to Firestore dictionary
    var dictionaryRepresentation: [String: Any] {
        return [
            "id": id,
            "title": title,
            "description": description,
            "date": date,
            "time": time,
            "category": category,
            "status": status,
            "sessionCount": sessionCount,
            "completedSessionCount": completedSessionCount,
            "sessionDuration": sessionDuration,
            "shortBreakDuration": shortBreakDuration,
            "longBreakDuration": longBreakDuration
        ]
    }
}
