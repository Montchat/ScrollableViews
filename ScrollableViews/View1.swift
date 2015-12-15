//
//  View1.swift
//  ScrollableViews
//
//  Created by Joe E. on 12/13/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit

class View1: UIViewController {

//    @IBOutlet weak var usernameTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
    
//    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBAction func loginPressed(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}

extension View1 : UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
//        changeConstraintTo(bottomConstraint, amount: 150, duration: 0.33)
        
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
//        changeConstraintTo(bottomConstraint, amount: 8, duration: 0.33)
        textField.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        changeConstraintTo(bottomConstraint, amount: 8, duration: 0.33)
        textField.resignFirstResponder()
        
        return true
    
    }
    
}

extension View1 {
        func changeConstraintTo(constraint:NSLayoutConstraint, amount: CGFloat, duration: Double) {
        UIView.animateWithDuration(duration) { () -> Void in
            constraint.constant = amount
            
        }
        
    }
    
    
}