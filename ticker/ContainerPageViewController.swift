//
//  ContainerPageViewController.swift
//  ticker
//
//  Created by Aaron Chen on 7/15/16.
//  Copyright © 2016 Aaron Chen. All rights reserved.

import UIKit

class ContainerPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIScrollViewDelegate, UIPageViewControllerDelegate {
    
    
    private lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVC("tasksvc"),
                self.newVC("tickervc"),
                self.newVC("settingsvc")]
    }()
    
    private func newVC(stringIdentifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewControllerWithIdentifier(stringIdentifier);
    }
    
    private var curIndex = 1
    private var nextIndex = 1
    
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad();
        dataSource = self
        delegate = self
        
        let middleVC = orderedViewControllers[1]
        
        setViewControllers([middleVC],
                           direction: .Forward,
                           animated: true,
                           completion: nil)
        
        for view in self.view.subviews {
            if view.isKindOfClass(UIScrollView) {
                (view as! UIScrollView).delegate = self;
                break;
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Scroll view Delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
            if curIndex == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
                scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0)
            } else if curIndex == 2 && scrollView.contentOffset.x > scrollView.bounds.size.width {
                scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
            }
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if curIndex == 0 && scrollView.contentOffset.x <= scrollView.bounds.size.width {
            targetContentOffset.memory = CGPointMake(scrollView.bounds.size.width, 0)
        } else if curIndex == 2 && scrollView.contentOffset.x >= scrollView.bounds.size.width {
            targetContentOffset.memory = CGPointMake(scrollView.bounds.size.width, 0);
        }
    }

    //MARK: ContainerPageViewController Data source!
    
    func pageViewController(_pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
    
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }

        
        return orderedViewControllers[nextIndex]
    }

    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        nextIndex = orderedViewControllers.indexOf(pendingViewControllers.first!)!;
    }
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        curIndex = 0
        if completed {
            curIndex = nextIndex
        }
    }
    
    
}