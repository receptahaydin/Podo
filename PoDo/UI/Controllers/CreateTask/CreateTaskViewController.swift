//
//  CreateTaskViewController.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 6.02.2024.
//

import UIKit
import FirebaseFirestore

protocol CreateTaskDelegate: AnyObject {
    func didCreateTask()
}

class CreateTaskViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryTextField: DesignableUITextField!
    @IBOutlet weak var focusTextField: DesignableUITextField!
    @IBOutlet weak var longTextField: DesignableUITextField!
    @IBOutlet weak var shortTextField: DesignableUITextField!
    @IBOutlet weak var sessionStepper: UIStepper!
    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDesc: UITextView!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: CreateTaskDelegate?
    var categories = ["Working", "Reading", "Coding", "Researching", "Training", "Meeting"]
    var focusTime = ["20 min", "25 min", "30 min", "35 min", "40 min", "45 min", "50 min", "55 min", "60 min"]
    var shortBreakTime = ["5 min", "10 min", "15 min", "20 min"]
    var longBreakTime = ["10 min", "15 min", "20 min", "25 min", "30 min"]
    let categoryPickerView = UIPickerView()
    let focusPickerView = UIPickerView()
    let shortPickerView = UIPickerView()
    let longPickerView = UIPickerView()
    let db = Firestore.firestore()
    let firestoreManager = FirestoreManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.isHidden = true
        pickerViewSettings()
        setDateComponents()
    }
    
    private func pickerViewSettings() {
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        focusPickerView.delegate = self
        focusPickerView.dataSource = self
        shortPickerView.delegate = self
        shortPickerView.dataSource = self
        longPickerView.delegate = self
        longPickerView.dataSource = self
        
        categoryTextField.inputView = categoryPickerView
        focusTextField.inputView = focusPickerView
        shortTextField.inputView = shortPickerView
        longTextField.inputView = longPickerView
        
        categoryPickerView.tag = 1
        focusPickerView.tag = 2
        shortPickerView.tag = 3
        longPickerView.tag = 4
    }
    
    private func setDateComponents() {
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        let minDate = calendar.date(byAdding: components, to: currentDate)!
        datePicker.minimumDate = minDate
    }
    
    private func getFormattedDate() -> (date: String, time: String) {
        let calendar = Calendar(identifier: .gregorian)
        let selectedDate = datePicker.date
        
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: selectedDate)
        components.timeZone = TimeZone(identifier: "UTC")
        
        let utcDate = calendar.date(from: components)!
        
        let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = "yyyy.MM.dd"
        dateFormatterDate.timeZone = TimeZone(identifier: "UTC")
        
        let dateFormatterTime = DateFormatter()
        dateFormatterTime.dateFormat = "HH:mm"
        dateFormatterTime.timeZone = TimeZone(identifier: "UTC")
        
        let formattedDate = dateFormatterDate.string(from: utcDate)
        let formattedTime = dateFormatterTime.string(from: utcDate)
        
        return (formattedDate, formattedTime)
    }
    
    private func extractNumber(from text: String) -> Int? {
        let filteredCharacters = text.filter { "0123456789".contains($0) }
        
        if let number = Int(filteredCharacters) {
            return number
        } else {
            return nil
        }
    }
    
    @IBAction func sessionValueChanged(_ sender: UIStepper) {
        let stepperValue = sessionStepper.value
        sessionLabel.text = "\(Int(stepperValue))"
        
        if (Int(stepperValue)) >= 4 {
            longTextField.isEnabled = true
            warningLabel.isHidden = true
        } else {
            longTextField.isEnabled = false
            warningLabel.isHidden = false
        }
    }
    
    @IBAction func createTaskAction(_ sender: UIButton) {
        
        guard let title = taskTitle.text, !title.isEmpty else {
            titleLabel.isHidden = false
            return
        }
        
        let formattedDateTime = getFormattedDate()
        let formattedDate = formattedDateTime.date
        let formattedTime = formattedDateTime.time
        
        let taskData: [String: Any] = [
            "title": taskTitle.text!,
            "description": taskDesc.text ?? "",
            "date": formattedDate,
            "time": formattedTime,
            "category": categoryTextField.text ?? "",
            "status": 0,
            "sessionCount": Int(sessionLabel.text!)!,
            "completedSessionCount": 0,
            "sessionDuration": extractNumber(from: focusTextField.text!)!,
            "shortBreakDuration": extractNumber(from: shortTextField.text!)!,
            "longBreakDuration": extractNumber(from: longTextField.text!)!
        ]
        
        let task = Task(data: taskData)
        self.firestoreManager.addTask(task: task)
        
        delegate?.didCreateTask()
        
        dismiss(animated: true, completion: nil)
    }
}

extension CreateTaskViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return categories.count
        case 2:
            return focusTime.count
        case 3:
            return shortBreakTime.count
        case 4:
            return longBreakTime.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return categories[row]
        case 2:
            return focusTime[row]
        case 3:
            return shortBreakTime[row]
        case 4:
            return longBreakTime[row]
        default:
            return "Data not found."
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            categoryTextField.text = categories[row]
        case 2:
            focusTextField.text = focusTime[row]
        case 3:
            shortTextField.text = shortBreakTime[row]
        case 4:
            longTextField.text = longBreakTime[row]
        default:
            return
        }
    }
}

extension CreateTaskViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        titleLabel.isHidden = true
        return true
    }
}
