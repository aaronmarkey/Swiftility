//
//  FirstViewController.swift
//  Swiftility
//
//  Created by Aaron Markey on 10/12/16.
//  Copyright © 2016 Aaron Markey. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var timer = NSTimer()
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
    @IBAction func datePickerAction(sender: UIDatePicker) {
        clockTime = sender.countDownDuration
    }
    
    @IBAction func playPauseAction(sender: UIBarButtonItem) {
        if(playPauseButtonOutlet.image == UIImage(imageLiteral: "play")) {
            playPauseButtonOutlet.image = UIImage(imageLiteral: "pause")
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:
                #selector(decrementClock), userInfo: nil, repeats: true)
            toggleDatePicker(false)
        } else {
            playPauseButtonOutlet.image = UIImage(imageLiteral: "play")
            timer.invalidate()
            pauseTime = clockTime
            toggleDatePicker(true)
        }

    }
    
    @IBAction func resetAction(sender: UIBarButtonItem) {
        timer.invalidate()
        clockTime = datePickerOutlet.countDownDuration
        playPauseButtonOutlet.image = UIImage(imageLiteral: "play")
        toggleDatePicker(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateComp : NSDateComponents = NSDateComponents()
        dateComp.hour = 0
        dateComp.minute = 1
        let calendar : NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let date : NSDate = calendar.dateFromComponents(dateComp)!
        datePickerOutlet.setDate(date, animated: true)
        
        clockTime = datePickerOutlet.countDownDuration
        timeLabel.font = UIFont(name: "AdvancedDotDigital-7", size: 30)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .All
    }
    
    
    
    //MARK: Utility Functions
    func decrementClock() {
        clockTime -= 1
        if(clockTime == 0) {
            timer.invalidate()
            playPauseButtonOutlet.image = UIImage(imageLiteral: "play")
            toggleDatePicker(true)
        }
    }

    func formatNumberAsTime(interval: Double) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        
        if(hours == 0) {
            return String(format: "%02d:%02d", minutes, seconds)
        }
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func toggleDatePicker(enabled: Bool) {
        datePickerOutlet.userInteractionEnabled = enabled
        
        if(enabled) {
            datePickerOutlet.alpha = 1.0
        } else {
            datePickerOutlet.alpha = 0.25
        }
    }

}

