//
//  ViewController1.swift
//  Swipe Navigation Xcode 7
//
//  Created by PJ Vea on 7/22/15.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class TickerViewController: UIViewController {
    
    @IBOutlet weak var button: UIView!
    
    @IBOutlet weak var tickerView: TickerView!
    
    @IBOutlet weak var pauseFlashImageView: UIImageView!
    
    @IBOutlet weak var pauseSymbolImageView: UIImageView!
    @IBAction func pauseButtonPressed(sender: UIButton) {
        if twData.timing {
            if twData.pauseTimer() {
                UIView.animateWithDuration(0.5, animations: {
                    self.pauseFlashImageView.alpha = 0.5
                    self.pauseSymbolImageView.alpha = 0.7
                })
            } else {
                UIView.animateWithDuration(0.5, animations: {
                    self.pauseFlashImageView.alpha = 0
                    self.pauseSymbolImageView.alpha = 0
                })
            }
        }
    }
    @IBAction func nextTaskButonPressed(sender: UIButton) {
    }
    
    var twData = ContainerViewController.twData

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func didReceivePanGesture(sender: UIPanGestureRecognizer) {
        
        let touches = sender.locationInView(nil);
        
        if sender.state == UIGestureRecognizerState.Began
        {
            twData.updateState(touches, angle: tickerView.angle, center: tickerView.center)
        }
        else if (sender.state == UIGestureRecognizerState.Changed)
        {
            tickerView.angle = twData.getAngle(touches, oldAngle: tickerView.angle)
            if twData.completed && !twData.timing {
                twData.startTimer(self)
            }
        }
    }
    
    
    dynamic func updateTimer()  {
        timeLabel.text = twData.getStringForTimer()
        tickerView.angle = twData.angle
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