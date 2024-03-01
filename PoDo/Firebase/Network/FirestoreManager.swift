//
//  FirestoreManager.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 1.03.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirestoreManager {
    
    let db = Firestore.firestore()
    
    func addUser(user: User) {
        db.collection("Users").document(getCurrentUserID()!).setData([
            "country": user.country,
            "countryCode": user.countryCode,
            "email": user.email,
            "name": user.name,
            "phoneNumber": user.phoneNumber,
            "photo": user.photo,
            "userId": getCurrentUserID()!
        ])
    }
    
    func addTask(task: Task) {
        db.collection("Users").document(getCurrentUserID()!).collection("Tasks").document().setData([
            "title": task.title,
            "description": task.description,
            "date": task.date,
            "time": task.time,
            "category": task.category,
            "status": task.status,
            "sessionCount": task.sessionCount,
            "completedSessionCount": task.completedSessionCount,
            "sessionDuration": task.sessionDuration,
            "shortBreakDuration": task.shortBreakDuration,
            "longBreakDuration": task.longBreakDuration
        ])
    }
    
    func getCurrentUserID() -> String? {
        if let user = Auth.auth().currentUser {
            return user.uid
        } else {
            return nil
        }
    }
}
