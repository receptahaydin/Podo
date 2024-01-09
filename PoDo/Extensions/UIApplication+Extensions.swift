//
//  UIApplication+Extensions.swift
//  CRXDCA
//
//  Created by Walid Baroudi on 10.05.2023.
//

import UIKit

extension UIApplication {
    func getActiveWindow() -> UIWindow? {
        connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .filter { $0.isKeyWindow }.first
    }
    
    func getTopViewController() -> UIViewController? {
        return getActiveWindow()?.topViewController()
    }
}
