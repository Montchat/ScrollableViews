//
//  View1.swift
//  ScrollableViews
//
//  Created by Joe E. on 12/13/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit
import Parse

private let STORYBOARD = "storyboard"

class View1: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBAction func loginPressed(sender: AnyObject) {
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        attemptUserLogin(username, password: password)
        
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
    
    func attemptUserLogin(username:String, password: String) {
        PFUser.logInWithUsernameInBackground(username, password: password) { (user, error) -> Void in
            if user != nil {
                guard let vc = UIStoryboard(name: STORYBOARD, bundle:  nil).instantiateInitialViewController() else { return }
                self.presentViewController(vc, animated: true, completion: nil)
                
            } else if error != nil {
                guard let error = error else { return }
                guard let string = error.userInfo["error"] as? String else { return }
                
                let alertVC = UIAlertController(title: "error", message: string, preferredStyle: UIAlertControllerStyle.Alert)
                
                alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
                    alertVC.dismissViewControllerAnimated(true, completion: nil)
                    
                }))
                
                self.presentViewController(alertVC, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
}