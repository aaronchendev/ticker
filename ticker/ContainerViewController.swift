//
//  AppDelegate.swift
//  ticker
//
//  Created by Aaron Chen on 7/15/16.
//  Copyright © 2016 Aaron Chen. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController
{

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupVCs()
    }
    
    
    static var twData = TickerWheelData()
    func setupVCs() {
        
        let vc0 = TaskViewController(nibName: "Task", bundle: nil)
    
        addChildViewController(vc0)
        scrollView.addSubview(vc0.view)
        vc0.didMoveToParentViewController(self)
        
        let vc1 = TickerViewController(nibName: "Ticker", bundle:nil)
        
        var frame1 = vc1.view.frame
        frame1.origin.x = self.view.frame.size.width
        vc1.view.frame = frame1
        
        addChildViewController(vc1)
        scrollView.addSubview(vc1.view)
        vc1.didMoveToParentViewController(self)
        
        let vc2 = SettingViewController(nibName: "Setting", bundle:nil)
        
        var frame2 = vc2.view.frame
        frame2.origin.x = view.frame.size.width * 2
        vc2.view.frame = frame2
        
        addChildViewController(vc2)
        scrollView.addSubview(vc2.view)
        vc2.didMoveToParentViewController(self)
        
        scrollView.contentSize = CGSizeMake(view.frame.size.width * 3, view.frame.size.height);
        
        scrollView.scrollRectToVisible(frame1, animated: false)
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

