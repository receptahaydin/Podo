//
//  ToDoViewController.swift
//  Podo
//
//  Created by Recep Taha Aydın on 20.04.2024.
//

import UIKit

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ToDoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lastItemIndex = collectionView.numberOfItems(inSection: indexPath.section) - 1
        if indexPath.item == lastItemIndex {
            self.performSegue(withIdentifier: "xx", sender: nil)
        } else {
            guard let selectedCell = collectionView.cellForItem(at: indexPath) else { return }
            let line = UIView(frame: CGRect(x: 0, y: selectedCell.frame.height - 2, width: selectedCell.frame.width, height: 2))
            line.backgroundColor = .podoRed
            line.tag = 100
            selectedCell.addSubview(line)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        for cell in collectionView.visibleCells {
            for subview in cell.subviews {
                if subview.tag == 100 {
                    subview.removeFromSuperview()
                }
            }
        }
    }
}

extension ToDoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellPadding: CGFloat = 15
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let lastItemIndex = collectionView.numberOfItems(inSection: indexPath.section) - 1
        
        if indexPath.row == 0 {
            cell.configure(name: "⭐")
        } else if indexPath.row == 3 {
            cell.configure(name: "Label dfmdfldmşfmdfşd")
        } else if indexPath.row == 6 {
            cell.configure(name: "sssss")
        } else if indexPath.row == lastItemIndex {
            cell.configure(name: "+ New List")
        } else {
            cell.configure(name: "x")
        }
        
        let labelSize = cell.listName.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        let cellWidth = labelSize.width + 2 * cellPadding
        return CGSize(width: cellWidth, height: 44)
    }
}


extension ToDoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let lastItemIndex = collectionView.numberOfItems(inSection: indexPath.section) - 1
        
        if indexPath.row == 0 {
            cell.configure(name: "⭐")
        } else if indexPath.row == 3 {
            cell.configure(name: "Label dfmdfldmşfmdfşd")
        } else if indexPath.row == 6 {
            cell.configure(name: "sssss")
        } else if indexPath.row == lastItemIndex {
            cell.configure(name: "+ New List")
        } else {
            cell.configure(name: "x")
        }
        
        return cell
    }
}
