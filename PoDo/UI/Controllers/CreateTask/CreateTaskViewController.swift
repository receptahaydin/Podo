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
    @IBOutlet weak var sessionStepper: UIStepper!
    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDesc: UITextView!
    
    var categories = ["Working", "Reading", "Coding", "Researching", "Training", "Meeting"]
    let pickerView = UIPickerView()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        categoryTextField.inputView = pickerView
        setDateComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDateComponents()
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
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = categories[row]
    }
}

