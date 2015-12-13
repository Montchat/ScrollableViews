//
//  ViewController.swift
//  ScrollableViews
//
//  Created by Joe E. on 12/13/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit

private let VIEW1 = "View1"
private let VIEW2 = "View2"
private let VIEW3 = "View3"

class ViewController: UIViewController {

    //MARK: @IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var submarineImageView: UIImageView!
    
    //MARK: GestureRecognizers - Outlets for setting delegates
    @IBOutlet var swipeGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var submarineGestureRecognizer: UILongPressGestureRecognizer!
    
    //Actions for telling the swipeGestureRecognizers what to do
    @IBAction func swipeGestureRecognizerAction(swipe: UISwipeGestureRecognizer) {
        if (swipe.state == .Began && swipe.direction == .Left) || (swipe.state == .Began && swipe.direction == .Right) {
            changeAlpha(submarineImageView, alpha: 0.50)
            
        }
        
        if swipe.state == .Ended {
            changeAlpha(submarineImageView, alpha: 1)
            
        }
        
    }
    
    @IBAction func submarineGestureReconizerAction(press: UILongPressGestureRecognizer) {
        if press.state == .Began {
            changeAlpha(submarineImageView, alpha: 0.50)
        }
        if press.state == .Ended {
            changeAlpha(submarineImageView, alpha: 1)

        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Creating our three viewControllers that will each contain their own view
        let loginVC = UIViewController(nibName: VIEW1,
            bundle: nil)
        let mainVC = UIViewController(nibName: VIEW2, bundle: nil)
        let signUpVC = UIViewController(nibName: VIEW3, bundle: nil)
        
        //Makes it look like the loginVC and the signUp VC are "stretchy"
        let greenSide = UIViewController(nibName: VIEW1, bundle: nil)
        let redSide = UIViewController(nibName: VIEW3, bundle: nil)

        //SideViews
        greenSide.view.frame.origin.x = view.frame.origin.x
        redSide.view.frame.origin.x = view.frame.midX
        view.addSubview(greenSide.view)
        view.addSubview(redSide.view)
        
        //MainViews
        scrollView.addSubview(loginVC.view)
        scrollView.addSubview(mainVC.view)
        scrollView.addSubview(signUpVC.view)
        
        view.bringSubviewToFront(scrollView)
        view.bringSubviewToFront(submarineImageView)
        
        //Laying out the different views in the scrollView
        mainVC.view.frame.origin.x = view.frame.width
        signUpVC.view.frame.origin.x = view.frame.width * 2
        
        //Adjusting the size of the scrollViews
        scrollView.contentSize = CGSize(width: view.frame.width * 3, height: view.frame.height)
        //Set the views so that the main view is in the middle and the login and signUp are on the left and right respectively.
        scrollView.setContentOffset(mainVC.view.frame.origin, animated: false)
        
        //Setting the delegates of the GestureRecoginzers above
        swipeGestureRecognizer.delegate = self
        submarineGestureRecognizer.delegate = self

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
}

extension ViewController : UIGestureRecognizerDelegate {
    //creating a function to set gesture recognizer delegates
    func setDelegate(gestureRecognizer: UIGestureRecognizer) {
        gestureRecognizer.delegate = self
        
    }
    
}

extension ViewController {
    //MARK: Functions
    func changeAlpha(view:UIView, alpha: Double) {
        UIView.animateWithDuration(0.33, animations: { () -> Void in
            view.alpha = 0.50
            
        })
        
    }
    
}