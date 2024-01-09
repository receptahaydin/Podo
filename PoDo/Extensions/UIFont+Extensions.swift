//
//  UIFont+Extensions.swift
//  ViTouch
//
//  Created by Anil Garip on 14.04.2022.
//

import UIKit

extension UIFont {
    static func regular(size: CGFloat = 17.0, isAdjustForDevice: Bool = false) -> UIFont {
        let font = systemFont(ofSize: size, weight: .regular)

        guard isAdjustForDevice else {
            return font
        }

        return font.adjustsFontSizeToFitDevice()

    }
    
    static func light(size: CGFloat = 17.0, isAdjustForDevice: Bool = false) -> UIFont {
        let font = systemFont(ofSize: size, weight: .light)

        guard isAdjustForDevice else {
            return font
        }

        return font.adjustsFontSizeToFitDevice()
    }
    
    static func medium(size: CGFloat = 17.0, isAdjustForDevice: Bool = false) -> UIFont {
        let font = systemFont(ofSize: size, weight: .medium)

        guard isAdjustForDevice else {
            return font
        }

        return font.adjustsFontSizeToFitDevice()
    }
    
    static func bold(size: CGFloat = 17.0, isAdjustForDevice: Bool = false) -> UIFont {
        let font = systemFont(ofSize: size, weight: .bold)

        guard isAdjustForDevice else {
            return font
        }

        return font.adjustsFontSizeToFitDevice()
    }

    func adjustsFontSizeToFitDevice() -> UIFont {
        switch UIDevice.current.screenSize {
        case .small:
            return self.withSize(self.pointSize - 2)
        case .large:
            return self.withSize(self.pointSize + 2)
        default:
            return self.withSize(self.pointSize)
        }
    }
}


protocol ViewStyleProtocol {
    func setDynamicFont(_ font: UIFont, textStyle: UIFont.TextStyle)
    func setRegularDynamicFont(size: CGFloat, textStyle: UIFont.TextStyle)
    func setBoldDynamicFont(size: CGFloat, textStyle: UIFont.TextStyle)
    func setLightDynamicFont(size: CGFloat, textStyle: UIFont.TextStyle)
    func setMediumDynamicFont(size: CGFloat, textStyle: UIFont.TextStyle)
}

extension ViewStyleProtocol {
    func setRegularDynamicFont(size: CGFloat, textStyle: UIFont.TextStyle = .body) {
        setDynamicFont(UIFont.regular(size: size, isAdjustForDevice: true), textStyle: textStyle)
    }
    func setBoldDynamicFont(size: CGFloat, textStyle: UIFont.TextStyle = .body) {
        setDynamicFont(UIFont.bold(size: size, isAdjustForDevice: true), textStyle: textStyle)
    }
    func setLightDynamicFont(size: CGFloat, textStyle: UIFont.TextStyle = .body) {
        setDynamicFont(UIFont.light(size: size, isAdjustForDevice: true), textStyle: textStyle)
    }
    func setMediumDynamicFont(size: CGFloat, textStyle: UIFont.TextStyle = .body) {
        setDynamicFont(UIFont.medium(size: size, isAdjustForDevice: true), textStyle: textStyle)
    }
}

extension ViewStyleProtocol where Self: UILabel {
    func setDynamicFont(_ font: UIFont, textStyle: UIFont.TextStyle = .body) {
        self.adjustsFontForContentSizeCategory = true
        self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
    }
}

extension ViewStyleProtocol where Self: UITextView  {
    func setDynamicFont(_ font: UIFont, textStyle: UIFont.TextStyle = .body) {
        self.adjustsFontForContentSizeCategory = true
        self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
    }
}

extension ViewStyleProtocol where Self: UITextField {
    func setDynamicFont(_ font: UIFont, textStyle: UIFont.TextStyle = .body) {
        self.adjustsFontForContentSizeCategory = true
        self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
    }
}

extension ViewStyleProtocol where Self: UIButton {
    func setDynamicFont(_ font: UIFont, textStyle: UIFont.TextStyle = .body) {
        self.titleLabel?.adjustsFontForContentSizeCategory = true
        self.titleLabel?.setDynamicFont(font, textStyle: textStyle)

    }
}

extension UILabel: ViewStyleProtocol { }
extension UITextView: ViewStyleProtocol { }
extension UITextField: ViewStyleProtocol { }
extension UIButton: ViewStyleProtocol { }
