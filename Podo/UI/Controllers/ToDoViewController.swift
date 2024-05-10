//
//  ToDoViewController.swift
//  Podo
//
//  Created by Recep Taha Aydın on 20.04.2024.
//

import UIKit

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let firestoreManager = FirestoreManager()
    
    private let floatingButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.backgroundColor = .PODORed
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        ListManager.shared.lists = []
        showLoadingIndicator()
        self.firestoreManager.readListsFromDatabase { [weak self] in
            self?.hideLoadingIndicator()
            self?.collectionView.reloadData()
        }
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let tabBarHeight = tabBarController?.tabBar.frame.size.height ?? 0
        let floatingButtonY = view.frame.size.height - tabBarHeight - 60 - 20
        
        floatingButton.frame = CGRect(x: view.frame.size.width - 70,
                                      y: floatingButtonY,
                                      width: 60,
                                      height: 60)
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: floatingButton.frame.size.height + 30, right: 0)
    }
    
    private func findSelectedList() -> String {
        let itemCount = collectionView.numberOfItems(inSection: 0)
        for index in 0..<itemCount {
            if let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) {
                for subview in cell.subviews {
                    if subview.tag == 100 {
                        print(index)
                    }
                }
            }
        }
    }
    
    @objc private func didTapFloatingButton() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let newItemVC = sb.instantiateViewController(withIdentifier: "newItemVC") as! NewItemViewController
       //newItemVC.listID = 
        self.present(newItemVC, animated: true)
    }
}

extension ToDoViewController: NewListDelegate {
    func didCreateList(list: List) {
        ListManager.shared.lists.append(list)
        collectionView.reloadData()
    }
}

extension ToDoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoTaskCell", for: indexPath) as! TodoTaskTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
}

extension ToDoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ListManager.shared.lists.count + 2
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        if indexPath.item == 0 {
            cell.configure(name: "⭐")
        } else if indexPath.item == ListManager.shared.lists.count + 1 {
            cell.configure(name: "+ New List")
        } else {
            let list = ListManager.shared.lists[indexPath.item - 1]
            cell.configure(name: list.title)
        }
        
        return cell
    }
}

extension ToDoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellPadding: CGFloat = 15
        var cellWidth: CGFloat = 0
        var labelSize: CGSize
        
        if indexPath.item == 0 {
            labelSize = "⭐".size(withAttributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)
            ])
        } else if indexPath.item == ListManager.shared.lists.count + 1 {
            labelSize = "+ New List".size(withAttributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)
            ])
        } else {
            labelSize = ListManager.shared.lists[indexPath.item - 1].title.size(withAttributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)
            ])
        }
        
        cellWidth = labelSize.width + 2 * cellPadding
        return CGSize(width: cellWidth, height: 44)
    }
}
