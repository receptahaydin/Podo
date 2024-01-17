//
//  SettingsViewController.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 12.01.2024.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logOutTapped(_ sender: LoaderButton) {
        sender.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "loginVC")
            
            if let sceneDelegate = UIApplication.shared.connectedScenes
                .first(where: { $0.delegate is SceneDelegate })?.delegate as? SceneDelegate,
               let window = sceneDelegate.window {
                
                UIView.transition(with: window, duration: 0.5, options: .transitionCurlUp, animations: {
                    window.rootViewController = vc
                }, completion: nil)
            }
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let topCell = tableView.dequeueReusableCell(withIdentifier: "topCell", for: indexPath)
            return topCell
        } else if indexPath.row == 1 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as! OptionTableViewCell
            optionCell.configureCell(image: UIImage(systemName: "person")!, title: "Edit Profile")
            return optionCell
        } else if indexPath.row == 2 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as! OptionTableViewCell
            optionCell.configureCell(image: UIImage(systemName: "star.fill")!, title: "Pomo Settings")
            return optionCell
        } else if indexPath.row == 3 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as! OptionTableViewCell
            optionCell.configureCell(image: UIImage(systemName: "bell.fill")!, title: "Notifications")
            return optionCell
        } else if indexPath.row == 4 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as! OptionTableViewCell
            optionCell.configureCell(image: UIImage(systemName: "person")!, title: "Help")
            return optionCell
        } else {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as! OptionTableViewCell
            optionCell.configureCell(image: UIImage(systemName: "person")!, title: "Help")
            return optionCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        } else {
            return 60
        }
    }
}
