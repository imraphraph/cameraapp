//
//  CreateAccountViewController.swift
//  cameraApp
//
//  Created by Raphael Lim on 8/09/2016.
//  Copyright © 2016 Raphael Lim. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameInputTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var fireBaseRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        usernameInputTextField.delegate = self
        
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CreateAccountViewController.dismissKeyboard)))
        
    }
    
    func dismissKeyboard() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        usernameInputTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func submitButton(sender: UIButton) {
        
        //unwrapping email and password else do nothing.
        guard let email = emailTextField.text, let password = passwordTextField.text, let username = usernameInputTextField.text else {
        return
        }
        
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: {(user, error)in
            if let person = user {
            
            let userDict = ["email": email, "username":username]
                self.fireBaseRef.child("users").child(person.uid).setValue(userDict)
            
                User.signIn(person.uid)
                
                self.performSegueWithIdentifier("HomeSegue", sender: nil)
            }else {
            let controller = UIAlertController(title: "Registration Failed", message: error?.localizedDescription, preferredStyle: .Alert)
            let dismissButton = UIAlertAction(title: "Try Again", style: .Default, handler: nil)
            
            controller.addAction(dismissButton)
            
            self.presentViewController(controller, animated: true, completion: nil)
                
            }
     
        })
    }
    


}
