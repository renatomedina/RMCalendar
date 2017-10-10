//
//  ViewController.swift
//  RMCalendar
//
//  Created by Renato Medina on 09/10/2017.
//  Copyright © 2017 Renato Medina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var startDate = Date().addingTimeInterval(-150*24*60*60) //last 150 days
    var endDate = Date() // today
    var currentDate: Date! = Date() //today
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: Actions
extension ViewController {
    @IBAction func openCalendar(_ sender: UIButton?) {
        self.showCalendar()
    }
}

extension ViewController {
    func showCalendar() {
        if let xibView = Bundle.main.loadNibNamed("CalendarPopUp", owner: nil, options: nil)?[0] as? CalendarPopUp {
            xibView.calendarDelegate = self
            xibView.selected = currentDate
            xibView.startDate = startDate
            xibView.endDate = endDate
            PopupContainer.generatePopupWithView(xibView).show()
        }
    }
}

extension ViewController: CalendarPopUpDelegate {
    func dateChaged(date: Date) {
        currentDate = date
    }
}

