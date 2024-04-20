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
}

extension ToDoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let colors: [UIColor] = [.red, .blue, .green, .yellow, .purple, .orange]
        let colorIndex = indexPath.row % colors.count
        cell.backgroundColor = colors[colorIndex]
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
