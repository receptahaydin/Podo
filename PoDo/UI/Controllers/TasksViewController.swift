//
//  TasksViewController.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 16.02.2024.
//

import UIKit

class TasksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    let firestoreManager = FirestoreManager()
    var selectedTask: Task?
    
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
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .podoRed
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var moreActions: UIAlertController = {
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let editAction = UIAlertAction(title: "Edit", style: .default) { _ in
            self.editTask()
        }
        editAction.setValue(UIColor.podoRed, forKey: "titleTextColor")
        alert.addAction(editAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { _ in
            self.presentDeleteConfirmationAlert()
        }
        deleteAction.setValue(UIColor.podoRed, forKey: "titleTextColor")
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        return alert
    }()
    
    private lazy var deleteAction: UIAlertController = {
        let alert = UIAlertController(
            title: nil,
            message: "Are you sure you want to delete this task?",
            preferredStyle: .alert
        )
        
        let yesAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            guard let taskToDelete = self.selectedTask else {
                return
            }
            
            self.firestoreManager.deleteTask(taskID: taskToDelete.id) { error in
                if let error = error {
                    print("Error deleting task: \(error.localizedDescription)")
                } else {
                    if let indexInFiltered = TaskManager.shared.filteredTasks.firstIndex(where: { $0.id == taskToDelete.id }) {
                        TaskManager.shared.filteredTasks.remove(at: indexInFiltered)
                    }
                    
                    if let indexInTasks = TaskManager.shared.tasks.firstIndex(where: { $0.id == taskToDelete.id }) {
                        TaskManager.shared.tasks.remove(at: indexInTasks)
                    }
                    
                    self.tableView.reloadData()
                }
            }
            
        }
        alert.addAction(yesAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        alert.addAction(cancelAction)
        
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskManager.shared.tasks = []
        TaskManager.shared.filteredTasks = []
        showLoadingIndicator()
        self.firestoreManager.readTaskFromDatabase { [weak self] in
            self?.hideLoadingIndicator()
            self?.segmentControlTapped(self?.segmentControl ?? UISegmentedControl())
        }
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let selectedSegmentIndex = self.segmentControl.selectedSegmentIndex
        self.filterTasks(for: selectedSegmentIndex)
        self.tableView.reloadData()
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
        let createTaskVC = sb.instantiateViewController(withIdentifier: "createTaskVC") as! CreateTaskViewController
        createTaskVC.delegate = self
        self.present(createTaskVC, animated: true)
    }
    
    @IBAction func calendarButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "tasksToCalendar", sender: nil)
    }
    
    @IBAction func moreButtonTapped(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            selectedTask = TaskManager.shared.filteredTasks[indexPath.row]
            present(moreActions, animated: true)
        }
    }
    
    @IBAction func trashButtonTapped(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            selectedTask = TaskManager.shared.filteredTasks[indexPath.row]
            presentDeleteConfirmationAlert()
        }
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            selectedTask = TaskManager.shared.filteredTasks[indexPath.row]
            
            if let tabBarController = self.tabBarController,
               let homeNavVC = tabBarController.viewControllers?[0] as? UINavigationController,
               let homeVC = homeNavVC.viewControllers.first as? HomeViewController {
                homeVC.selectedTask = selectedTask
                homeVC.setRoadMap()
                tabBarController.selectedIndex = 0
            }
        }
    }
    
    @IBAction func segmentControlTapped(_ sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex
        filterTasks(for: selectedSegmentIndex)
        tableView.reloadData()
    }
    
    private func presentDeleteConfirmationAlert() {
        present(deleteAction, animated: true)
    }
    
    private func editTask() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let createTaskVC = sb.instantiateViewController(withIdentifier: "createTaskVC") as! CreateTaskViewController
        createTaskVC.delegate = self
        createTaskVC.selectedTask = selectedTask
        self.present(createTaskVC, animated: true)
    }
    
    private func filterTasks(for status: Int) {
        switch status {
        case 0:
            TaskManager.shared.filteredTasks = TaskManager.shared.tasks.filter { $0.status == 0 }
        case 1:
            TaskManager.shared.filteredTasks = TaskManager.shared.tasks.filter { $0.status == 1 }
        case 2:
            TaskManager.shared.filteredTasks = TaskManager.shared.tasks.filter { $0.status == 2 }
        default:
            break
        }
    }
    
    private func showLoadingIndicator() {
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        loadingIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }
}

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = TaskManager.shared.filteredTasks[indexPath.row]
        
        if task.status == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "completedTaskCell", for: indexPath) as! CompletedTaskCell
            cell.configureCell(task: task)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "uncompletedTaskCell", for: indexPath) as! UncompletedTaskCell
            cell.configureCell(task: task)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskManager.shared.filteredTasks.count
    }
}

extension TasksViewController: UITableViewDelegate {
    
}

extension TasksViewController: CreateTaskDelegate {
    func didCreateTask() {
        showLoadingIndicator()
        self.firestoreManager.readTaskFromDatabase { [weak self] in
            self?.hideLoadingIndicator()
            if let selectedSegmentIndex = self?.segmentControl.selectedSegmentIndex {
                self?.filterTasks(for: selectedSegmentIndex)
            }
            self?.tableView.reloadData()
        }
    }
}
