//
//  ToDoViewController.swift
//  Podo
//
//  Created by Recep Taha Aydın on 20.04.2024.
//

import UIKit

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var lists: [String] = ["⭐", "A", "B"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ToDoViewController: NewListDelegate {
    func didCreateList(name: String) {
        lists.append(name)
        collectionView.reloadData()
    }
}

extension ToDoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lastItemIndex = collectionView.numberOfItems(inSection: indexPath.section) - 1
        if indexPath.item == lastItemIndex {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let newListVC = sb.instantiateViewController(withIdentifier: "newListVC") as! NewListViewController
            newListVC.delegate = self
            self.present(newListVC, animated: true)
        } else {
            guard let selectedCell = collectionView.cellForItem(at: indexPath) else { return }
            let line = UIView(frame: CGRect(x: 0, y: selectedCell.frame.height - 2, width: selectedCell.frame.width, height: 2))
            line.backgroundColor = .podoRed
            line.tag = 100
            selectedCell.addSubview(line)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let itemCount = collectionView.numberOfItems(inSection: 0)
        for index in 0..<itemCount {
            if let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) {
                for subview in cell.subviews {
                    if subview.tag == 100 {
                        subview.removeFromSuperview()
                    }
                }
            }
        }
    }
}

extension ToDoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == lists.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
            cell.configure(name: "+ New Task")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
            cell.configure(name: lists[indexPath.item])
            return cell
        }
    }
}

extension ToDoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellPadding: CGFloat = 15

        var cellWidth: CGFloat = 0

        if indexPath.item == lists.count {
            // Calculate width for "+ New Task" cell
            let labelSize = "+ New Task".size(withAttributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17) // Adjust font size as needed
            ])
            cellWidth = labelSize.width + 2 * cellPadding
        } else {
            // Calculate width for other cells
            let labelSize = lists[indexPath.item].size(withAttributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17) // Adjust font size as needed
            ])
            cellWidth = labelSize.width + 2 * cellPadding
        }

        return CGSize(width: cellWidth, height: 44) // Adjust height as needed
    }
}
