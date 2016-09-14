//
//  ImageCaptionViewController.swift
//  cameraApp
//
//  Created by Hahaboy on 14/09/2016.
//  Copyright © 2016 Raphael Lim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SDWebImage

class ImageCaptionViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedImage = UIImage()
    
    @IBOutlet weak var captionTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = self.selectedImage
        
    }
    
    @IBAction func onDoneButtonPressed(sender: AnyObject) {
        
        let uniqueImageName = NSUUID().UUIDString
        let storageRef = FIRStorage.storage().reference().child("\(uniqueImageName).png")
        
        let selectedImage = UIImagePNGRepresentation(self.selectedImage)!
        storageRef.putData(selectedImage, metadata: nil, completion: { (metadata, error) in
            if error != nil{
                print(error)
                return
            }
            
            
            let currentUserRef = DataService.imageRef.childByAutoId()
            if let imageURL = metadata?.downloadURL()?.absoluteString, user = User.currentUserUid(), caption = self.captionTextField.text{
                let value = ["imgurl":imageURL, "userUID":user, "created_at":NSDate().timeIntervalSince1970, "caption":caption]
                currentUserRef.setValue(value)
                
                
                FIRDatabase.database().reference().child("users").child(user).child("images").updateChildValues([currentUserRef.key: true])
                
                SDImageCache.sharedImageCache().storeImage(self.selectedImage, forKey: imageURL)
            }
            
            
        })
        performSegueWithIdentifier("unwindToHomeTabBar", sender: self)
        //self.dismissViewControllerAnimated(true, completion: {});
        
        
    }

}
