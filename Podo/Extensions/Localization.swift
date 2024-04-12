//
//  Localization.swift
//  CRXDCA
//
//  Created by Recep Taha Aydın on 16.08.2023.
//

import Foundation

protocol Localizable {
    var localized: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return NSLocalizedString(rawValue, comment: "")
    }
}

public struct Localization {
}
