//
//  SecondViewController.swift
//  Swiftility
//
//  Created by Aaron Markey on 10/12/16.
//  Copyright © 2016 Aaron Markey. All rights reserved.
//

import UIKit

class TemperatureViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: Properties
    let fDegrees = Array(-129...134)
    let cDegrees = Array(-90...57)
    
    var fString: Array<String> = []
    var cString: Array<String> = []

    //MARK: Outlets
    @IBOutlet weak var tempPickerOutlet: UIPickerView!
    @IBOutlet weak var convertedTempLabel: UILabel!
    @IBOutlet weak var switchOutlet: UISegmentedControl!
    
    
    //MARK: Actions
    @IBAction func switchAction(sender: UISegmentedControl) {
        tempPickerOutlet.reloadAllComponents()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempPickerOutlet.dataSource = self
        tempPickerOutlet.delegate = self
        
        fString = setPickerItems(fDegrees, type: "F")
        cString = setPickerItems(cDegrees, type: "C")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(switchOutlet.selectedSegmentIndex == 0) {
            return fDegrees.count
        } else {
            return cDegrees.count
        }
    }
    
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(switchOutlet.selectedSegmentIndex == 0) {
            return fString[row]
        } else {
            return cString[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(switchOutlet.selectedSegmentIndex == 0) {
        } else {
        }
    }

    
    //MARK: Functions
    func setPickerItems(values: Array<Int>, type: String) -> Array<String> {
        var stringOfValues: Array<String> = []
        for i in values {
            stringOfValues += ["\(i) \u{00B0}\(type)"]
        }
        
        return stringOfValues
    }

}

