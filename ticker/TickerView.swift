//
//  TickerView.swift
//  ticker
//
//  Created by Aaron Chen on 7/19/16.
//  Copyright © 2016 Aaron Chen. All rights reserved.
//

import UIKit

class TickerView: UIView {

    var angle = CGFloat() {
        didSet {
            transform = CGAffineTransformMakeRotation(angle)
        }
    }

}
