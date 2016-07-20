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
    
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var twData = TickerWheelData()

    
    @IBAction func didReceivePanGesture(sender: UIPanGestureRecognizer) {
        
        let touches = sender.locationInView(nil);
        
        if sender.state == UIGestureRecognizerState.Began
        {
            twData.updateState(touches, angle: tickerView.angle, center: tickerView.center)
        }
        else if (sender.state == UIGestureRecognizerState.Changed)
        {
            tickerView.angle = twData.getAngle(touches)
        }
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