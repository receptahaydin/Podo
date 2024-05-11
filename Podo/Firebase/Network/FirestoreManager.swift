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
    
    func addList(list: List) {
        db.collection("Users").document(getCurrentUserID()!).collection("TodoLists").document().setData([
            "createdDate": list.createdDate,
            "title": list.title
        ])
    }
    
    func addListItem(item: ListItem) {
        db.collection("Users").document(getCurrentUserID()!).collection("Todos").document().setData([
            "isCompleted": item.isCompleted,
            "isFavourite": item.isFavourite,
            "listId": item.listId,
            "title": item.title
        ])
    }
    
    func readListsFromDatabase(completion: @escaping () -> Void) {
        let listsCollection = db.collection("Users").document(getCurrentUserID()!).collection("TodoLists")
        
        listsCollection.order(by: "createdDate").getDocuments { (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                var lists: [List] = []
                
                for document in querySnapshot!.documents {
                    let data = document.data()
                    var list = List(data: data)
                    list.id = document.documentID
                    lists.append(list)
                }
                
                ListManager.shared.lists = lists
                completion()
            }
        }
    }
    
    func readItemsFromDatabase(completion: @escaping () -> Void) {
        let itemsCollection = db.collection("Users").document(getCurrentUserID()!).collection("Todos")
        
        itemsCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                var items: [ListItem] = []
                
                for document in querySnapshot!.documents {
                    let data = document.data()
                    var item = ListItem(data: data)
                    item.id = document.documentID
                    items.append(item)
                }
                
                ItemManager.shared.items = items
                completion()
            }
        }
    }
    
    func readTasksFromDatabase(completion: @escaping () -> Void) {
        let tasksCollection = db.collection("Users").document(getCurrentUserID()!).collection("Tasks")
        
        tasksCollection.order(by: "date").getDocuments { (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                var tasks: [Task] = []
                
                for document in querySnapshot!.documents {
                    let data = document.data()
                    var task = Task(data: data)
                    task.id = document.documentID
                    tasks.append(task)
                }
                
                TaskManager.shared.tasks = tasks
                completion()
            }
        }
    }
    
    func deleteTask(taskID: String, completion: @escaping (Error?) -> Void) {
        let taskDocumentRef = db.collection("Users").document(getCurrentUserID()!).collection("Tasks").document(taskID)
        
        taskDocumentRef.delete { error in
            if let error = error {
                print("Error deleting task: \(error.localizedDescription)")
            } else {
                print("Task deleted successfully.")
            }
            
            completion(error)
        }
    }
    
    func updateTask(taskID: String, updatedData: [String: Any], completion: @escaping (Error?) -> Void) {
        let taskDocumentRef = db.collection("Users").document(getCurrentUserID()!).collection("Tasks").document(taskID)
        
        taskDocumentRef.updateData(updatedData) { error in
            if let error = error {
                print("Error updating task: \(error.localizedDescription)")
            } else {
                print("Task updated successfully.")
            }
            
            completion(error)
        }
    }
    
    func incrementCompletedSessionCount(taskID: String, completion: @escaping (Error?) -> Void) {
        let taskDocumentRef = db.collection("Users").document(getCurrentUserID()!).collection("Tasks").document(taskID)
        
        taskDocumentRef.updateData(["completedSessionCount": FieldValue.increment(Int64(1))]) { error in
            if let error = error {
                print("Error incrementing completedSessionCount: \(error.localizedDescription)")
            } else {
                print("completedSessionCount incremented successfully.")
            }
            
            completion(error)
        }
    }
    
    func updateTaskStatus(taskID: String, newStatus: Int, completion: @escaping (Error?) -> Void) {
        let taskDocumentRef = db.collection("Users").document(getCurrentUserID()!).collection("Tasks").document(taskID)
        
        taskDocumentRef.updateData(["status": newStatus]) { error in
            if let error = error {
                print("Error updating task status: \(error.localizedDescription)")
            } else {
                print("Task status updated successfully.")
            }
            
            completion(error)
        }
    }
    
    func getUserInfo(completion: @escaping (String?, String?) -> Void) {
        if let currentUser = Auth.auth().currentUser {
            let userDocumentRef = db.collection("Users").document(currentUser.uid)
            
            userDocumentRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    let name = data?["name"] as? String
                    let email = data?["email"] as? String
                    completion(name, email)
                } else {
                    print("User document does not exist")
                    completion(nil, nil)
                }
            }
        } else {
            print("No user logged in")
            completion(nil, nil)
        }
    }
    
    func getCurrentUserID() -> String? {
        if let user = Auth.auth().currentUser {
            return user.uid
        } else {
            return nil
        }
    }
}
