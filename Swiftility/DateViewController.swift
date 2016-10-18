//
//  DateViewController.swift
//  Swiftility
//
//  Created by Aaron Markey on 10/12/16.
//  Copyright © 2016 Aaron Markey. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var startDateOutlet: UIDatePicker!
    @IBOutlet weak var endDateOutlet: UIDatePicker!
    @IBOutlet weak var intervalLabel: UILabel!
    
    
    //MARK: Actions
    @IBAction func startDateAction(sender: UIDatePicker) {
        endDateOutlet.minimumDate = sender.date
    }
    
    @IBAction func endDateAction(sender: UIDatePicker) {
        startDateOutlet.maximumDate = sender.date
    }
    
    @IBAction func calculateButton(sender: UIButton) {
        
        //calculate time between the two dates
        let interval = endDateOutlet.date.timeIntervalSinceDate(startDateOutlet.date)
        
        //convert to days
        let timeInDays = Double(interval)/86400
        let rounded = Int(round(timeInDays))
        
        let tag = rounded == 1 ? "Day" : "Days"
        
        intervalLabel.text = "\(rounded) \(tag)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intervalLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .All
    }
    

}
