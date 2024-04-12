//
//  ImageManager.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 20.03.2024.
//

import Foundation
import UIKit

class ImageManager {
    
    func saveProfileImageToDevice(_ image: UIImage, userID: String) {
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            let fileManager = FileManager.default
            let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let imagePath = documentsPath.appendingPathComponent("profileImage_\(userID).jpg")
            if fileManager.fileExists(atPath: imagePath.path) {
                do {
                    try fileManager.removeItem(at: imagePath)
                } catch {
                    print("Error removing existing profile image: \(error.localizedDescription)")
                }
            }
            do {
                try imageData.write(to: imagePath)
                print("Profile image saved to device.")
            } catch {
                print("Error saving profile image to device: \(error.localizedDescription)")
            }
        }
    }
    
    func loadProfileImageFromDevice(userID: String) -> UIImage? {
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imagePath = documentsPath.appendingPathComponent("profileImage_\(userID).jpg")
        if fileManager.fileExists(atPath: imagePath.path) {
            if let imageData = try? Data(contentsOf: imagePath) {
                return UIImage(data: imageData)
            }
        } else {
            if let defaultImage = UIImage(named: "profile.jpg") {
                return defaultImage
            }
        }
        return nil
    }
}
