//
//  SettingsViewController.swift
//  cameraApp
//
//  Created by Raphael Lim on 13/09/2016.
//  Copyright © 2016 Raphael Lim. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.descriptionTextField.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard)))
    }
    
    func dismissKeyboard() {
        descriptionTextField.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func settingsButton(sender: UIButton) {
        
        try! FIRAuth.auth()!.signOut()
        NSUserDefaults.standardUserDefaults().removeObjectForKey("uid")
        
        let storyboard = UIStoryboard(name: "Main", bundle:  NSBundle.mainBundle())
        let viewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController")
        
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    @IBAction func saveButton(sender: UIButton) {
        
        let subtitle = self.descriptionTextField.text
        
        FIRDatabase.database().reference().child("users").child(User.currentUserUid()!).child("subtitle").setValue(subtitle)
    }
    
    
    
    
    }

