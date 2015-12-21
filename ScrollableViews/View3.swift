//
//  View3.swift
//  ScrollableViews
//
//  Created by Joe E. on 12/13/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit
import Parse

private let STORYBOARD = "Users"

class View3: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBAction func signUpPressed(sender: AnyObject) {
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let email = emailTextField.text else { return }
        
        signUpUser(username, password: password, email: email)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension View3 : UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        changeConstraintTo(bottomConstraint, amount: 300, duration: 0.33)
        
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        changeConstraintTo(bottomConstraint, amount: 8, duration: 0.33)
        textField.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        changeConstraintTo(bottomConstraint, amount: 8, duration: 0.33)
        textField.resignFirstResponder()
        
        return true
        
    }
    
    func changeConstraintTo(constraint:NSLayoutConstraint, amount: CGFloat, duration: Double) {
        UIView.animateWithDuration(duration) { () -> Void in
            constraint.constant = amount
            
        }
        
    }
    
}

extension View3 {
    
    func signUpUser(username: String, password: String, email: String) {
        let currentUser = PFUser()
        
        currentUser.username = username
        currentUser.password = password
        currentUser.email = email
        
        let userData = PFObject(className: "UserData")
        userData["followers"] = []
        currentUser["userData"] = userData
        
        currentUser.signUpInBackgroundWithBlock { (Bool, error) -> Void in
            if let error = error {
                let string = error.userInfo["error"] as? String
                let alertVC = UIAlertController(title: "error", message: string, preferredStyle: UIAlertControllerStyle.Alert)
                alertVC.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
                    alertVC.dismissViewControllerAnimated(true, completion: nil)
                    
                }))
                
                self.presentViewController(alertVC, animated: true, completion: nil)
                
            } else {
                userData["user"] = currentUser
                
                userData.saveInBackgroundWithBlock({ (Bool, error) -> Void in
                    print(error)
                    
                })
                
                guard let vc = UIStoryboard(name: STORYBOARD, bundle: nil).instantiateInitialViewController() else { return }
                self.presentViewController(vc, animated: true, completion: nil)
                
                
            }
            
        }

    }
    
    
    
}