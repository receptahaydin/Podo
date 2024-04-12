//
//  CALayerExtensions.swift
//  CRXDCA
//
//  Created by Recep Taha Aydın on 20.11.2023.
//

import Foundation
import UIKit

extension CALayer {
    func setRoundedCorners() {
        self.cornerRadius = 5.0
        self.masksToBounds = true
    }
        
    func makeRounded(cornerRadius: CGFloat? = nil) {
        if let cornerRadius = cornerRadius {
            self.cornerRadius = cornerRadius
        } else {
            self.cornerRadius = self.bounds.height / 2
        }
        self.masksToBounds = true
    }
    
    func dropInvisionShadow(cornerRadius: CGFloat = 4) {
        self.cornerRadius = cornerRadius
        self.shadowOffset = CGSize(width: 0, height: 2)
        self.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.2).cgColor
        self.shadowOpacity = 1
        self.shadowRadius = 2
        self.masksToBounds = false
    }
    
    func dropShadow() {
        self.shadowOffset = CGSize(width: 0, height: 1)
        self.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.2).cgColor
        self.shadowOpacity = 1
        self.shadowRadius = 4
        self.masksToBounds = false
    }
}
