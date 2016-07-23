//
//  ViewController1.swift
//  Swipe Navigation Xcode 7
//
//  Created by PJ Vea on 7/22/15.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class TickerViewController: UIViewController {
    
    
    @IBOutlet var tickerView: TickerView!
 
    @IBAction func pauseButtonPressed(sender: UIButton) {
        if twData.timing {
            twData.pauseTimer() ? tickerView.animatePause() : tickerView.animatePlay()
        }
    }
    @IBAction func nextTaskButonPressed(sender: UIButton) {
        
    }
    
    var twData = ContainerViewController.twData

    
    @IBAction func didReceivePanGesture(sender: UIPanGestureRecognizer) {
        
        let touches = sender.locationInView(nil);
        let tickerSubView = tickerView.tickerSubView
        
        if sender.state == UIGestureRecognizerState.Began
        {
            twData.updateState(touches, angle: tickerSubView.angle, center: tickerSubView.center)
        }
        else if (sender.state == UIGestureRecognizerState.Changed)
        {
            tickerSubView.angle = twData.getAngle(touches, oldAngle: tickerSubView.angle)
            if twData.completed && !twData.timing {
                twData.startTimer(self)
                tickerView.animateCircle(twData.totalTime)
            }
        }
    }
    
    
    dynamic func updateTimer()  {
        tickerView.timeLabel.text = twData.getStringForTimer()
        tickerView.tickerSubView.angle = twData.angle
    }
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}