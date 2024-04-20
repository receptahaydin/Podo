//
//  ToDoViewController.swift
//  Podo
//
//  Created by Recep Taha Aydın on 20.04.2024.
//

import UIKit

class ToDoViewController: UIViewController {
    
    
    

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
            
            // indexPath.row kullanarak farklı bir renk seç
            let colorIndex = indexPath.row % colors.count
            cell.backgroundColor = colors[colorIndex]
            
            return cell
    }
}
