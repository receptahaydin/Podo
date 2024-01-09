//
//  UITableView+Extensions.swift
//  ViTouch
//
//  Created by Anil Garip on 14.04.2022.
//

import UIKit

extension UITableViewCell: Reusable {

}

extension UITableViewHeaderFooterView: Reusable {

}

public extension UITableView {

    func register<T: UITableViewCell>(_ cellType: T.Type, reuseIdentifier: String? = nil) {
        if cellType.nibName == "UITableViewCell" {
            self.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier ?? cellType.reuseIdentifier)
        } else {
            self.register(cellType.nib, forCellReuseIdentifier: reuseIdentifier ?? cellType.reuseIdentifier)
        }
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }

    func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type = T.self) -> T {
        let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier) as! T
        return cell
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self, reuseIdentifier: String? = nil) -> T {
        let cell = self.dequeueReusableCell(withIdentifier: reuseIdentifier ?? cellType.reuseIdentifier, for: indexPath) as! T
        return cell
    }

    func register<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type, reuseIdentifier: String? = nil) {
        if headerFooterViewType.nibName == "UITableViewHeaderFooterView" {
            self.register(headerFooterViewType.classForCoder(), forHeaderFooterViewReuseIdentifier: reuseIdentifier ?? headerFooterViewType.reuseIdentifier)
        } else {
            self.register(headerFooterViewType.nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier ?? headerFooterViewType.reuseIdentifier)
        }
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self, reuseIdentifier: String? = nil) -> T? {
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier ?? viewType.reuseIdentifier) as? T? else { return nil }
        return view
    }
}
