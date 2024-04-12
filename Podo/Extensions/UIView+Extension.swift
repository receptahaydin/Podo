//
//  UIView+Extension.swift
//  CRXVitals
//
//  Created by Anil Garip on 21.11.2022.
//  Copyright © 2022 CareX.ai. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

extension UIView {
    
    func roundCorners(radius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
    }
}

extension UIView {
    
    func copyView<T: UIView>() -> T? {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T
        } catch {
            return nil
        }
    }
}

extension UIStackView {
    func clearSubviews() {
        arrangedSubviews.forEach { subview in subview.removeFromSuperview() }
    }
}
