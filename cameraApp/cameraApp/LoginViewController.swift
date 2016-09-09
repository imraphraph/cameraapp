//
//  ViewController.swift
//  cameraApp
//
//  Created by Raphael Lim on 8/09/2016.
//  Copyright © 2016 Raphael Lim. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("dismissKeyboard")))
        
    }
    
    func dismissKeyboard() {
    emailTextField.resignFirstResponder()
    passwordTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    
    @IBAction func loginButton(sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
        return
        }
        FIRAuth.auth()?.signInWithEmail(email, password: password) { (user, error) in
            if let person = user {
                
                User.signIn(person.uid)
                
                self.performSegueWithIdentifier("HomeSegue", sender: nil)

            }else {
                let controller = UIAlertController(title: "Registration Failed", message: error?.localizedDescription, preferredStyle: .Alert)
                let dismissButton = UIAlertAction(title: "Try Again", style: .Default, handler: nil)
                
                controller.addAction(dismissButton)
                
                self.presentViewController(controller, animated: true, completion: nil)
            }
            
        }
    }
    
    
    //allows for the backToLogin segue
    @IBAction func backToLogin (segue: UIStoryboardSegue){
    
   
    }

}

