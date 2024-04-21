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
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCell = collectionView.cellForItem(at: indexPath) else { return }
        let line = UIView(frame: CGRect(x: 0, y: selectedCell.frame.height - 2, width: selectedCell.frame.width, height: 2))
        line.backgroundColor = .podoRed
        line.tag = 100
        selectedCell.addSubview(line)
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
        
        if indexPath.row == 3 {
            cell.configure(name: "Label dfmdfldmşfmdfşd")
        } else if indexPath.row == 6 {
            cell.configure(name: "sssss")
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
        
        if indexPath.row == 3 {
            cell.configure(name: "Label dfmdfldmşfmdfşd")
        } else if indexPath.row == 6{
            cell.configure(name: "sssss")
        } else {
            cell.configure(name: "x")
        }
        
        return cell
    }
}
