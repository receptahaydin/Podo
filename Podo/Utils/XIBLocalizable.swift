//
//  XIBLocalizable.swift
//  ViTouch
//
//  Created by Anil Garip on 14.04.2022.
//

import UIKit

protocol XIBLocalizable {
    var xibLocalizable: String? { get set }
    var xibPlaceholderLocalizable: String? { get set }
    var xibSelectedTitleLocalizable: String? { get set }
    var xibArguments: String? { get set }
}

extension XIBLocalizable {
    var xibPlaceholderLocalizable: String? {
        get { return nil }
        set { }
    }

    var xibSelectedTitleLocalizable: String? {
        get { return nil }
        set { }
    }

    var xibArguments: String? {
        get { return nil }
        set { }
    }
}

extension UILabel: XIBLocalizable {
    @IBInspectable
    var xibLocalizable: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }

    @IBInspectable
    var xibArguments: String? {
        get { return nil }
        set(arguments) {
            guard let format = text else { return }
            guard let vals = arguments?.components(separatedBy: ",").map({ (k) -> String in
                k.trimmingCharacters(in: .whitespacesAndNewlines).localized
            }) else { return }

            text = String(format: format, arguments: vals)
        }
    }
}

extension UIButton: XIBLocalizable {
    @IBInspectable
    var xibLocalizable: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
    }
}

extension UITextView: XIBLocalizable {
    @IBInspectable
    var xibLocalizable: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}

extension UITextField: XIBLocalizable {
    @IBInspectable
    var xibLocalizable: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }

    @IBInspectable
    var xibPlaceholderLocalizable: String? {
        get { return nil }
        set(key) {
            placeholder = key?.localized
        }
    }
}

extension UISegmentedControl: XIBLocalizable {
    @IBInspectable
    var xibLocalizable: String? {
        get { return nil }
        set(arguments) {
            guard let keys = arguments?.components(separatedBy: ",").map({ (k) -> String in
                k.trimmingCharacters(in: .whitespacesAndNewlines).localized
            }) else { return }

            for i in 0..<keys.count {
                self.setTitle(keys[i], forSegmentAt: i)
            }
        }
    }
}
