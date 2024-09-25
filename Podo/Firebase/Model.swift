//
//  TaskStruct.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 12.02.2024.
//

import FirebaseFirestore

struct User {
    var country: String
    var countryCode: String
    var email: String
    var name: String
    var phoneNumber: String

    init(data: [String: Any]) {
        country = data["country"] as? String ?? ""
        countryCode = data["countryCode"] as? String ?? ""
        email = data["email"] as? String ?? ""
        name = data["name"] as? String ?? ""
        phoneNumber = data["phoneNumber"] as? String ?? ""
    }
}

struct Task {
    var id: String
    var title: String
    var description: String
    var date: String
    var time: String
    var category: String
    var status: Int
    var sessionCount: Int
    var completedSessionCount: Int
    var sessionDuration: Int
    var shortBreakDuration: Int
    var longBreakDuration: Int

    init(data: [String: Any]) {
        self.id = ""
        title = data["title"] as? String ?? ""
        description = data["description"] as? String ?? ""
        date = data["date"] as? String ?? ""
        time = data["time"] as? String ?? ""
        category = data["category"] as? String ?? ""
        status = data["status"] as? Int ?? 0
        sessionCount = data["sessionCount"] as? Int ?? 0
        completedSessionCount = data["completedSessionCount"] as? Int ?? 0
        sessionDuration = data["sessionDuration"] as? Int ?? 0
        shortBreakDuration = data["shortBreakDuration"] as? Int ?? 0
        longBreakDuration = data["longBreakDuration"] as? Int ?? 0
    }
}

struct List {
    var id: String
    var createdDate: String
    var title: String
    
    init(data: [String: Any]) {
        self.id = ""
        createdDate = data["createdDate"] as? String ?? ""
        title = data["title"] as? String ?? ""
    }
}

struct ListItem {
    var id: String
    var isCompleted: Bool
    var isFavourite: Bool
    var listId: String
    var title: String
    
    init(data: [String: Any]) {
        self.id = ""
        isCompleted = data["isCompleted"] as? Bool ?? false
        isFavourite = data["isFavourite"] as? Bool ?? false
        listId = data["listId"] as? String ?? ""
        title = data["title"] as? String ?? ""
    }
}
