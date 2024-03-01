//
//  SplashViewController.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 9.01.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SplashViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserAuthentication()
        
    }
    
    func checkUserAuthentication() {
        if Auth.auth().currentUser != nil {
            DispatchQueue.main.async {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController
                vc?.modalPresentationStyle = .fullScreen
                self.present(vc!, animated: false)
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "signupVC")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            }
        }
    }
    
    /*func readTaskFromDatabase() {
        let tasksCollection = db.collection("Task")
        
        tasksCollection.getDocuments { [weak self] (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                var tasks: [TaskModel] = []
                
                for document in querySnapshot!.documents {
                    let documentID = document.documentID
                    let data = document.data()
                    
                    let task = TaskModel(documentID: documentID, dictionary: data)
                    tasks.append(task)
                }
                
                TaskManager.shared.tasks = tasks
                
                DispatchQueue.main.async {
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    let vc = sb.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController
                    vc?.modalPresentationStyle = .fullScreen
                    self!.present(vc!, animated: false)
                }
            }
        }
    }*/
}
