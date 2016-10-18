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
    
    var holdF: Int = 0
    var holdC: Int = 0

    //MARK: Outlets
    @IBOutlet weak var tempPickerOutlet: UIPickerView!
    @IBOutlet weak var convertedTempLabel: UILabel!
    @IBOutlet weak var switchOutlet: UISegmentedControl!
    
    
    //MARK: Actions
    @IBAction func switchAction(sender: UISegmentedControl) {
        
        //reload UI when segment changes
        if(sender.selectedSegmentIndex == 0) {
            tempPickerOutlet.selectRow(holdF, inComponent: 0, animated: false)
            convertToC(fDegrees[holdF])
            tempPickerOutlet.reloadAllComponents()
        } else {
            tempPickerOutlet.selectRow(holdC, inComponent: 0, animated: false)
            convertToF(cDegrees[holdC])
            tempPickerOutlet.reloadAllComponents()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set picker data source and delegate
        tempPickerOutlet.dataSource = self
        tempPickerOutlet.delegate = self
        
        //generate array of strings of degrees
        fString = setPickerItems(fDegrees, type: "F")
        cString = setPickerItems(cDegrees, type: "C")
        
        //convert initial C on screen
        convertToC(fDegrees[holdF])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .All
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
            holdF = row
            convertToC(fDegrees[row])
        } else {
            holdC = row
            convertToF(cDegrees[row])
        }
    }

    
    //MARK: Functions
    
    /**
     Formats an array of ints into a string in the format "int degree".
     
     - Parameter values: Array of all Int values for the degrees avail.
     - Parameter style: The type degree. F or c.
     
     - Returns: The array of formatted strings.
     */
    func setPickerItems(values: Array<Int>, type: String) -> Array<String> {
        var stringOfValues: Array<String> = []
        for i in values {
            stringOfValues += ["\(i) \u{00B0}\(type)"]
        }
        
        return stringOfValues
    }
    
    
    /**
     Converts F to C
     
     - Parameter degree: The number to be converted.
    */
    func convertToC(degree: Int) {
        let c = Double((degree - 32)) * (5/9)
        convertedTempLabel.text = String(format: "%0.2f \u{00B0}C", c)
    }
    
    /**
     Converts C to F
     
     - Parameter degree: The number to be converted.
     */
    func convertToF(degree: Int) {
        let f = (Double(degree) * 9/5) + 32.0
        convertedTempLabel.text = String(format: "%0.2f \u{00B0}F", f)
    }

}

