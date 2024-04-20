//
//  Tabbar.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 15.03.2024.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        let tabBar = self.tabBar
        
        let timerSelectImage = UIImage(systemName: "stopwatch.fill")
        let tasksSelectImage = UIImage(systemName: "list.bullet.rectangle.fill")
        let toDoSelectImage = UIImage(systemName: "checkmark.square.fill")
        let analyticsSelectImage = UIImage(systemName: "chart.bar.fill")
        let settingsSelectImage = UIImage(systemName: "gearshape.fill")

        (tabBar.items![0]).selectedImage = timerSelectImage
        (tabBar.items![1]).selectedImage = tasksSelectImage
        (tabBar.items![2]).selectedImage = toDoSelectImage
        (tabBar.items![3]).selectedImage = analyticsSelectImage
        (tabBar.items![4]).selectedImage = settingsSelectImage
    }
}
