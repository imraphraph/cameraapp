//
//  ForgotPasswordViewController.swift
//  cameraApp
//
//  Created by Raphael Lim on 9/09/2016.
//  Copyright © 2016 Raphael Lim. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
      
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ForgotPasswordViewController.dismissKeyboard)))
        
    }
    
    func dismissKeyboard() {
        emailTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func submitButton(sender: AnyObject) {
        
        if let email = emailTextField.text {
            
            FIRAuth.auth()?.sendPasswordResetWithEmail(email, completion: {(error) in
             
                var title = ""
                var message = ""
                
                if error != nil
                {
                title = "Oops"
                message = (error?.localizedDescription)!
                }else {
                title = "success"
                message = "Password reset email sent"
                self.emailTextField.text = ""
                    
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
                let alertButton = UIAlertAction(title: "Try Again", style: .Cancel, handler: nil)
                    
                alertController.addAction(alertButton)
                    
                self.presentViewController(alertController, animated: true, completion: nil)

                }
                
            })
        
        }else{
        
            let alertController = UIAlertController(title: "Password Reset Failure", message: "Please enter an email", preferredStyle: .Alert)
            let alertButton = UIAlertAction(title: "Try Again", style: .Cancel, handler: nil)
            
            alertController.addAction(alertButton)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
}
