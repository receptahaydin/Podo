//
//  ProfileTableViewCell.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 20.03.2024.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    let imageManager = ImageManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImage.cornerRadius = profileImage.frame.height / 2
        profileImage.image = imageManager.loadProfileImageFromDevice(userID: FirestoreManager().getCurrentUserID()!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true
        
        fetchUserInfo()
    }
    
    @objc func imageViewTapped() {
        NotificationCenter.default.post(name: Notification.Name("ProfileImageTapped"), object: nil)
    }
    
    func fetchUserInfo() {
        loadingIndicator.startAnimating()
        
        FirestoreManager().getUserInfo { name, email in
            DispatchQueue.main.async {
                self.name.text = name ?? "Name not found"
                self.email.text = email ?? "Email not found"
                
                self.loadingIndicator.stopAnimating()
            }
        }
    }
}
