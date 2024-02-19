//
//  CreateTaskViewController.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 6.02.2024.
//

import UIKit
import FirebaseFirestore

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
    
    var categories = ["Working", "Reading", "Coding", "Researching", "Training", "Meeting"]
    var focusTime = ["20", "25", "30", "35", "40", "45", "50", "55", "60"]
    var shortBreakTime = ["5", "10", "15", "20"]
    var longBreakTime = ["10", "15", "20", "25", "30"]
    let categoryPickerView = UIPickerView()
    let focusPickerView = UIPickerView()
    let shortPickerView = UIPickerView()
    let longPickerView = UIPickerView()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewSettings()
        setDateComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    private func getFormattedDate(date: Date? = nil) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let selectedDate = date ?? datePicker.date
        
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: selectedDate)
        components.timeZone = TimeZone(identifier: "UTC")
        
        let utcDate = calendar.date(from: components)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        return dateFormatter.string(from: utcDate)
    }
    
    @IBAction func sessionValueChanged(_ sender: UIStepper) {
        let stepperValue = sessionStepper.value
        sessionLabel.text = "\(Int(stepperValue))"
    }
    
    @IBAction func createTaskAction(_ sender: UIButton) {
        
        let firestoreData: [String: Any] = [
            "title": taskTitle.text ?? "",
            "description": taskDesc.text ?? "",
            "createdDate": getFormattedDate(date: Date()),
            "taskTime": getFormattedDate(),
            "category": categoryTextField.text ?? "",
            "status": 0,
            "sessionCount": sessionLabel.text ?? "",
            "completedSessionCount": 0
        ]
        
        let task = TaskModel(dictionary: firestoreData)
        let newCityRef = db.collection("Task").document()
        
        newCityRef.setData(task.dictionaryRepresentation)
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

