//
//  FirstViewController.swift
//  Swiftility
//
//  Created by Aaron Markey on 10/12/16.
//  Copyright © 2016 Aaron Markey. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var timer = Timer()
    var clockTime = 0.0 {
        didSet {
            timeLabel.text = formatNumberAsTime(clockTime)
        }
    }
    var pauseTime = 0.0
    

    //MARK: Outlets
    @IBOutlet weak var playPauseButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    
    //MARK: Actions
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        clockTime = sender.countDownDuration
    }
    
    @IBAction func playPauseAction(_ sender: UIBarButtonItem) {
        
        //if button is play when pressed, start timer
        if(playPauseButtonOutlet.image == UIImage(named: "play")) {
            playPauseButtonOutlet.image = UIImage(named: "pause")
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:
                #selector(decrementClock), userInfo: nil, repeats: true)
            toggleDatePicker(false)
            
        //else end timer
        } else {
            playPauseButtonOutlet.image = UIImage(named: "play")
            timer.invalidate()
            pauseTime = clockTime
            toggleDatePicker(true)
        }

    }
    
    //reset the timer to the value of the picker
    @IBAction func resetAction(_ sender: UIBarButtonItem) {
        timer.invalidate()
        clockTime = datePickerOutlet.countDownDuration
        playPauseButtonOutlet.image = UIImage(named: "play")
        toggleDatePicker(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set an initial value to the date picker. Work around for a bug in the 
        //date picker class.
        var dateComp : DateComponents = DateComponents()
        dateComp.hour = 0
        dateComp.minute = 1
        let calendar : Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let date : Date = calendar.date(from: dateComp)!
        datePickerOutlet.setDate(date, animated: true)
        
        clockTime = datePickerOutlet.countDownDuration
        
        //set custom font
        timeLabel.font = UIFont(name: "AdvancedDotDigital-7", size: 30)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .all
    }
    
    
    
    //MARK: Utility Functions
    
    /**
     Decrements timer by 1 second, and invalidates timer if it reaches 0.
     */
    func decrementClock() {
        clockTime -= 1
        if(clockTime == 0) {
            timer.invalidate()
            playPauseButtonOutlet.image = UIImage(named: "play")
            toggleDatePicker(true)
        }
    }

    /**
     Formats aa number in the format HH:MM:SS.
     
     - Parameter interval: The number to format
     
     - Returns: A String the above format.
     */
    func formatNumberAsTime(_ interval: Double) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        
        if(hours == 0) {
            return String(format: "%02d:%02d", minutes, seconds)
        }
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    /**
     Toggles the ability of the picker to be edited.
     
     - Parameter enabled: If true, picker is enabled.
    */
    func toggleDatePicker(_ enabled: Bool) {
        datePickerOutlet.isUserInteractionEnabled = enabled
        
        if(enabled) {
            datePickerOutlet.alpha = 1.0
        } else {
            datePickerOutlet.alpha = 0.25
        }
    }

}

