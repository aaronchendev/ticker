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
    
    var begin = state()
    
    func updateState(touches: CGPoint, angle : CGFloat, center: CGPoint ) {
        begin.touch  = touches
        begin.angle  = angle
        begin.center = center
        begin.touchAngle = getCGPointAngle(begin.touch!, b: begin.center!)
    }
    
    func getAngle(touches: CGPoint) -> CGFloat {
        let newTouchAngle = getCGPointAngle(touches, b : begin.center!)
        var angle = begin.angle! - (begin.touchAngle! - newTouchAngle)
        if angle < 0 {
            angle += 2 * CGFloat.getPI()
        } else if angle > 2 * CGFloat.getPI() {
            angle -= 2 * CGFloat.getPI()
        }
        return angle
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