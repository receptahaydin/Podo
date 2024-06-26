//
//  CalendarViewController.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 4.03.2024.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    var toggleButton = UIBarButtonItem()
    var isWeeklyMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.select(Date(), scrollToDate: true)
        showTasks(for: Date())
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        toggleButton = UIBarButtonItem(
            title: "Week",
            style: .plain,
            target: self,
            action: #selector(toggleMode)
        )
        navigationItem.rightBarButtonItem = toggleButton
    }
    
    @objc func toggleMode() {
        isWeeklyMode.toggle()
        updateCalendarMode()
    }
    
    func updateCalendarMode() {
        if isWeeklyMode {
            calendar.scope = .week
            toggleButton.title = "Month"
            calendarHeightConstraint.constant = 120
        } else {
            calendar.scope = .month
            toggleButton.title = "Week"
            calendarHeightConstraint.constant = 300
        }
        showTasks(for: calendar.selectedDate ?? Date())
    }
    
    func showTasks(for date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let formattedDate = dateFormatter.string(from: date)
        
        TaskManager.shared.filteredTasks = TaskManager.shared.tasks.filter { $0.date == formattedDate }
        tableView.reloadData()
    }
}

extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "calendarCell", for: indexPath) as! CalendarTableViewCell
        let task = TaskManager.shared.filteredTasks[indexPath.row]
        cell.configureCell(task: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskManager.shared.filteredTasks.count
    }
}

extension CalendarViewController: UITableViewDelegate {
    
}

extension CalendarViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        showTasks(for: date)
    }
}

extension CalendarViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let formattedDate = dateFormatter.string(from: date)
        
        let tasksForDate = TaskManager.shared.tasks.filter { $0.date == formattedDate }
        return tasksForDate.count
    }
}
