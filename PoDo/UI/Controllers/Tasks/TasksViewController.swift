//
//  TasksViewController.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 16.02.2024.
//

import UIKit

class TasksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
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
    
    @objc private func didTapFloatingButton() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "createTaskVC")
        self.present(vc, animated: true)
    }
}

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
}

extension TasksViewController: UITableViewDelegate {

}

