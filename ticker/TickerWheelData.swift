//
//  TickerWheelData.swift
//  ticker
//
//  Created by Aaron Chen on 7/19/16.
//  Copyright © 2016 Aaron Chen. All rights reserved.
//

import Foundation
import UIKit

struct state
{
    var touch : CGPoint?         // Current touch position
    var angle : CGFloat?         // Angle of the view
    var touchAngle : CGFloat?    // Angle between the finger and the view
    var center : CGPoint?        // Center of the view
};

class TickerWheelData {
    
    // MARK: angle data functions
    
    private var begin = state()
    
    var angle = CGFloat()
    
    var halfway = false
    
    var completed = false
    
    var timing = false
    
    var totalTime : NSTimeInterval = 300
    
    func updateState(touches: CGPoint, angle : CGFloat, center: CGPoint ) {
        begin.touch  = touches
        begin.angle  = angle
        begin.center = center
        begin.touchAngle = getCGPointAngle(begin.touch!, b: begin.center!)
    }
    
    func getAngle(touches: CGPoint, oldAngle : CGFloat) -> CGFloat {
        if completed {
            return oldAngle
        }
        let newTouchAngle = getCGPointAngle(touches, b : begin.center!)
        var angle = begin.angle! - (begin.touchAngle! - newTouchAngle)
        if angle < 0 {
            angle += 2 * CGFloat.getPI()
        } else if angle > 2 * CGFloat.getPI() {
            angle -= 2 * CGFloat.getPI()
        }
        if 2.5 ... 3.5 ~= angle {
            halfway = true
        } else if 0.5 ... 2.5 ~= angle {
            halfway = false
        }
        if oldAngle > 6 && angle < 0.1 { // on the edge
            if halfway && !completed {
                    completed = true
            }
            return 0
        }
        completed = false
        return angle
    }
    
    // MARK : Timer data functions
    
    private var timer : NSTimer?
    private var startDate = NSDate()
    private var oldDate = NSDate()
    
    private var paused = false
    
    func startTimer(sender: AnyObject) {
        timing = true
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: sender, selector: #selector(TickerViewController.updateTimer), userInfo: nil, repeats: true);
        startDate = NSDate();
    }
    
    func pauseTimer() -> Bool {
        if paused {
            let time = oldDate.timeIntervalSinceDate(startDate)
            startDate = NSDate(timeIntervalSinceNow: -time)
        } else {
            oldDate = NSDate()
        }
        paused = !paused
        return paused
    }
    
    func stopTimer() {
        timing = false
        timer?.invalidate();
    }
    
    func getStringForTimer() -> String {
        // Create date from the elapsed time
        let  currentDate = paused ? oldDate : NSDate();
        let timeInterval = currentDate.timeIntervalSinceDate(startDate);
        
        //300 seconds count down
        let timeIntervalCountDown = totalTime - timeInterval;
        angle = CGFloat((timeInterval / totalTime) * 2 * M_PI)
        
        let timerDate = NSDate(timeIntervalSince1970: timeIntervalCountDown);
        
        // Create a date formatter
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "mm:ss";
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0);
        
        // Format the elapsed time and set it to the label
        let timeString = dateFormatter.stringFromDate(timerDate);
        return timeString;
    }
    
    //Helper Functions
    
    func getCGPointAngle(a : CGPoint,  b : CGPoint) -> CGFloat
    {
        return atan2(a.y - b.y, a.x - b.x);
    }
    
    
    func getCGPointDistance( a : CGPoint, b : CGPoint) -> CGFloat
    {
        return sqrt(pow((a.x - b.x), 2) + pow((a.y - b.y), 2));
    }
    
    
}

extension CGFloat {
    private static func getPI() -> CGFloat{
        return CGFloat(M_PI)
    }
}