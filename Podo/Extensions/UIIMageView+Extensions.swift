//
//  UIIMageView+Extensions.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 17.01.2024.
//

import UIKit

extension UIImageView {
    
    public func maskCircle() {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}
