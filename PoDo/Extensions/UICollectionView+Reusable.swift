//
//  UICollectionView+Reusable.swift
//  CareX Measurement Conference
//
//  Created by Walid Baroudi on 18.08.2022.
//

import Foundation

import UIKit

// MARK: Reusable support for UICollectionView

extension UICollectionReusableView: Reusable {}

extension UICollectionView {
    func register(_ cellType: (some UICollectionViewCell).Type, reuseIdentifier: String? = nil) {
        let identifier = reuseIdentifier ?? cellType.reuseIdentifier
        if cellType.nibName == "UICollectionViewCell" {
            self.register(cellType.classForCoder(), forCellWithReuseIdentifier: identifier)
        } else {
            self.register(cellType.nib, forCellWithReuseIdentifier: identifier)
        }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self, reuseIdentifier: String? = nil) -> T {
        let cell = self.dequeueReusableCell(withReuseIdentifier: reuseIdentifier ?? cellType.reuseIdentifier, for: indexPath) as! T
        return cell
    }

    func register(supplementaryViewType: (some UICollectionReusableView).Type, ofKind elementKind: String, reuseIdentifier: String? = nil) {
        if supplementaryViewType.nibName == "UICollectionReusableView" {
            self.register(supplementaryViewType.classForCoder(), forSupplementaryViewOfKind: elementKind, withReuseIdentifier: reuseIdentifier ?? supplementaryViewType.reuseIdentifier)
        } else {
            self.register(
                supplementaryViewType.nib,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: reuseIdentifier ?? supplementaryViewType.reuseIdentifier
            )
        }
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, for indexPath: IndexPath, viewType: T.Type = T.self, reuseIdentifier: String? = nil) -> T {
        let view = self.dequeueReusableSupplementaryView(
            ofKind: elementKind,
            withReuseIdentifier: reuseIdentifier ?? viewType.reuseIdentifier,
            for: indexPath
        )
        guard let typedView = view as? T else {
            fatalError(
                "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) "
                    + "matching type \(viewType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the supplementary view beforehand"
            )
        }
        return typedView
    }
}
