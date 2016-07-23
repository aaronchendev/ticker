//
//  TickerView.swift
//  ticker
//
//  Created by Aaron Chen on 7/22/16.
//  Copyright © 2016 Aaron Chen. All rights reserved.
//

import UIKit
import Foundation

class TickerView: UIView {

    
    @IBOutlet weak var tickerSubView: TickerSubView!
    
    @IBOutlet weak var pauseFlashImageView: UIImageView!
    
    @IBOutlet weak var pauseSymbolImageView: UIImageView!
    
    @IBOutlet weak var ringImageView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    let circleLayer = CAShapeLayer()

    override init(frame: CGRect) {
        let circlePath = UIBezierPath(arcCenter: ringImageView.center, radius: ringImageView.frame.size.width, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        circleLayer.path = circlePath.CGPath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.strokeColor = UIColor.redColor().CGColor
        circleLayer.lineWidth = 5.0
        circleLayer.strokeEnd = 0.0
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        layer.addSublayer(circleLayer)
    }
    
    func animateCircle(duration: NSTimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        circleLayer.strokeEnd = 1.0
        circleLayer.addAnimation(animation, forKey: "animateCircle")
        print("animating circle")
    }

    func pauseLayer(layer: CALayer) {
        circleLayer.speed = 0.0
        circleLayer.timeOffset = circleLayer.convertTime(CACurrentMediaTime(), fromLayer: nil)
    }
    
    func resumeLayer(layer: CALayer) {
        let pausedTime = circleLayer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        circleLayer.speed = 1.0
        circleLayer.timeOffset = 0.0;
        circleLayer.beginTime = 0.0;
        circleLayer.beginTime = circleLayer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    func animatePause() {
        UIView.animateWithDuration(0.3, animations: {
            self.pauseFlashImageView.alpha = 0.5
            self.pauseSymbolImageView.alpha = 0.7
        })
    }
    
    func animatePlay() {
        UIView.animateWithDuration(0.5, animations: {
            self.pauseFlashImageView.alpha = 0
            self.pauseSymbolImageView.alpha = 0
        })
    }
    
}
