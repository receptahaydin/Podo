//
//  RoundedButton.swift
//  PO-DO
//
//  Created by Recep Taha Aydın on 2.01.2024.
//

import Foundation
import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var roundedButton: Bool = false {
        didSet {
            if roundedButton {
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if roundedButton {
            layer.cornerRadius = frame.height / 2
        }
    }
}
