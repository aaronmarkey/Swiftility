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
    @IBOutlet weak var playPauseButtonOutlet: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    
    //MARK: Actions
    @IBAction func datePickerAction(sender: UIDatePicker) {
        clockTime = sender.countDownDuration
    }
    
    @IBAction func playPauseAction(sender: UIButton) {
        if(playPauseButtonOutlet.currentImage == UIImage(imageLiteral: "play")) {
            playPauseButtonOutlet.setImage(UIImage(imageLiteral: "pause"), forState: .Normal)
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:
                #selector(decrementClock), userInfo: nil, repeats: true)
            datePickerOutlet.userInteractionEnabled = false
            datePickerOutlet.alpha = 0.25
        } else {
            playPauseButtonOutlet.setImage(UIImage(imageLiteral: "play"), forState: .Normal)
            timer.invalidate()
            pauseTime = clockTime
            datePickerOutlet.userInteractionEnabled = true
            datePickerOutlet.alpha = 1.0
        }
    }
    
    @IBAction func resetAction(sender: UIButton) {
        timer.invalidate()
        clockTime = datePickerOutlet.countDownDuration
        playPauseButtonOutlet.setImage(UIImage(imageLiteral: "play"), forState: .Normal)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        clockTime = datePickerOutlet.countDownDuration

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func decrementClock() {
        clockTime -= 1
        if(clockTime == 0) {
            timer.invalidate()
        }
    }

    func formatNumberAsTime(interval: Double) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

}

