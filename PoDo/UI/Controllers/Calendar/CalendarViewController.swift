//
//  CalendarViewController.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 4.03.2024.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate {

    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
