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
    
    let imageManager = ImageManager()
    
    private lazy var logoutAction: UIAlertController = {
        let alert = UIAlertController(
            title: "Logout",
            message: "Are you sure you want to log out?",
            preferredStyle: .alert
        )
        
        let yesAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                try? Auth.auth().signOut()
                
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
        alert.addAction(yesAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        alert.addAction(cancelAction)
        
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleProfileImageTap), name: Notification.Name("ProfileImageTapped"), object: nil)
    }
    
    @objc func handleProfileImageTap() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage,
           let profileCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ProfileTableViewCell {
            imageManager.saveProfileImageToDevice(image, userID: FirestoreManager().getCurrentUserID()!)
            profileCell.profileImage.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let profileCell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileTableViewCell
            return profileCell
        } else if indexPath.row == 1 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as! OptionTableViewCell
            optionCell.configureCell(image: UIImage(systemName: "person.fill")!, title: "Edit Profile")
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
            optionCell.configureCell(image: UIImage(systemName: "info.circle.fill")!, title: "Help")
            return optionCell
        } else if indexPath.row == 5 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath) as! SwitchTableViewCell
            optionCell.configureCell(image: UIImage(systemName: "eye.fill")!, title: "Dark Theme")
            return optionCell
        } else {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as! OptionTableViewCell
            optionCell.configureCell(image: UIImage(systemName: "rectangle.portrait.and.arrow.right.fill")!, title: "Logout")
            return optionCell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        } else {
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 6 {
            present(logoutAction, animated: true)
        }
    }
}
