//
//  UIButton+Extensions.swift
//  CRXDCA
//
//  Created by Walid Baroudi on 19.05.2023.
//

import UIKit

typealias UIButtonTargetClosure = (UIButton) -> Void

extension UIButton {
    func action(closure: @escaping UIButtonTargetClosure) {
        addAction(UIAction(handler: {_ in closure(self) }), for: .touchUpInside)
    }
}
