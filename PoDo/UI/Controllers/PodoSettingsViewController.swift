//
//  PodoSettingsViewController.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 30.03.2024.
//

import UIKit

class PodoSettingsViewController: UIViewController {
    
    @IBOutlet weak var sessionStepper: UIStepper!
    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var focusTextField: DesignableUITextField!
    @IBOutlet weak var shortTextField: DesignableUITextField!
    @IBOutlet weak var longTextField: DesignableUITextField!
    @IBOutlet weak var longBreakLabel: UILabel!
    
    var focusTime = ["20 min", "25 min", "30 min", "35 min", "40 min", "45 min", "50 min", "55 min", "60 min"]
    var shortBreakTime = ["5 min", "10 min", "15 min", "20 min"]
    var longBreakTime = ["10 min", "15 min", "20 min", "25 min", "30 min"]
    let focusPickerView = UIPickerView()
    let shortPickerView = UIPickerView()
    let longPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewSettings()
        sessionStepper.addTarget(self, action: #selector(updateSessionLabel), for: .valueChanged)
        fetchPodoSettings()
    }
    
    private func fetchPodoSettings() {
        let defaults = UserDefaults.standard
        let focusValue = defaults.string(forKey: "FocusTime") ?? "25 min"
        let shortBreakValue = defaults.string(forKey: "ShortBreakTime") ?? "5 min"
        let longBreakValue = defaults.string(forKey: "LongBreakTime") ?? "15 min"
        let sessionValue = defaults.string(forKey: "SessionLabelValue") ?? "1"
        
        focusTextField.text = focusValue
        shortTextField.text = shortBreakValue
        longTextField.text = longBreakValue
        sessionLabel.text = sessionValue
        sessionStepper.value = Double(sessionValue) ?? 1.0
        updateSessionLabel()
    }
    
    private func pickerViewSettings() {
        focusPickerView.delegate = self
        focusPickerView.dataSource = self
        shortPickerView.delegate = self
        shortPickerView.dataSource = self
        longPickerView.delegate = self
        longPickerView.dataSource = self
        
        focusTextField.inputView = focusPickerView
        shortTextField.inputView = shortPickerView
        longTextField.inputView = longPickerView
        
        focusPickerView.tag = 1
        shortPickerView.tag = 2
        longPickerView.tag = 3
    }
    
    @objc private func updateSessionLabel() {
        let stepperValue = sessionStepper.value
        sessionLabel.text = "\(Int(stepperValue))"
    }
    
    @IBAction func saveChangesAction(_ sender: UIButton) {
        let focusValue = focusTextField.text!
        let shortBreakValue = shortTextField.text!
        let longBreakValue = longTextField.text!
        let sessionValue = sessionLabel.text!
        
        let defaults = UserDefaults.standard
        defaults.set(focusValue, forKey: "FocusTime")
        defaults.set(shortBreakValue, forKey: "ShortBreakTime")
        defaults.set(longBreakValue, forKey: "LongBreakTime")
        defaults.set(sessionValue, forKey: "SessionLabelValue")

        dismiss(animated: true, completion: nil)
    }
}

extension PodoSettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return focusTime.count
        case 2:
            return shortBreakTime.count
        case 3:
            return longBreakTime.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return focusTime[row]
        case 2:
            return shortBreakTime[row]
        case 3:
            return longBreakTime[row]
        default:
            return "Data not found."
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            focusTextField.text = focusTime[row]
        case 2:
            shortTextField.text = shortBreakTime[row]
        case 3:
            longTextField.text = longBreakTime[row]
        default:
            return
        }
    }
}
