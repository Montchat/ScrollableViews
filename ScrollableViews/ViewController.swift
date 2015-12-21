//
//  ViewController.swift
//  ScrollableViews
//
//  Created by Joe E. on 12/13/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit
import Parse

private let VIEW1 = "View1"
private let VIEW2 = "View2"
private let VIEW3 = "View3"

class ViewController: UIViewController {

    //MARK: @IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: GestureRecognizers - Outlets for setting delegates
    @IBOutlet var swipeGestureRecognizer: UISwipeGestureRecognizer!
    
    //Actions for telling the swipeGestureRecognizers what to do
    @IBAction func swipeGestureRecognizerAction(swipe: UISwipeGestureRecognizer) {
        if (swipe.state == .Began && swipe.direction == .Left) || (swipe.state == .Began && swipe.direction == .Right) {
           
        }
        
        if swipe.state == .Ended {
            
        }
        
    }
    
    let loginVC = View1(nibName: VIEW1,
        bundle: nil)
    let mainVC = View2(nibName: VIEW2, bundle: nil)
    let signUpVC = View3(nibName: VIEW3, bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Creating our three viewControllers that will each contain their own view
        
        //Makes it look like the loginVC and the signUpVC are "stretchy"
        let greenSide = UIView(frame: view.frame)
        let redSide = UIView(frame: view.frame)

        //SideViews
//        greenSide.view.frame.origin.x = scrollView.frame.origin.x
        
        greenSide.frame.origin = view.frame.origin
        greenSide.backgroundColor = loginVC.view.backgroundColor
        redSide.frame.origin.x = view.frame.midX
        redSide.backgroundColor = signUpVC.view.backgroundColor
        
//        redSide.view.frame.origin.x = view.frame.midX
        view.addSubview(greenSide)
        view.addSubview(redSide)

        //MainViews
        scrollView.addSubview(loginVC.view)
        scrollView.addSubview(mainVC.view)
        scrollView.addSubview(signUpVC.view)

        view.bringSubviewToFront(scrollView)

        //Laying out the different views in the scrollView
        mainVC.view.frame.origin.x = view.frame.width
        signUpVC.view.frame.origin.x = view.frame.width * 2
        
        //Adjusting the size of the scrollViews
        scrollView.contentSize = CGSize(width: view.frame.width * 3, height: view.frame.height)
        //Set the views so that the main view is in the middle and the login and signUp are on the left and right respectively.
        scrollView.setContentOffset(mainVC.view.frame.origin, animated: false)
        
        //Setting the delegates of the GestureRecoginzers above
        swipeGestureRecognizer.delegate = self

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

extension ViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    
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