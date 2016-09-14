//
//  ProfileTabPage.swift
//  cameraApp
//
//  Created by Raphael Lim on 9/09/2016.
//  Copyright © 2016 Raphael Lim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage



class ProfileTabPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var titleTextField: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var profileImageUrl : String?
    var username: String?
    var subtitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
        profileImageView.userInteractionEnabled = true

//_________________________________________(Loading barbutton programmatically)_____________________________________________
        
        // set barbutton programatically
        let settingImage = UIImage(named: "Settings")
        
        // set button programatically
        let customSettingButton = UIButton(type: .Custom)
        customSettingButton.setImage(settingImage, forState: .Normal)
        customSettingButton.addTarget(self, action: #selector(openSetting), forControlEvents: .TouchUpInside)
        customSettingButton.frame = CGRectMake(0, 0, 40, 40)
        
        // set custom barbutton programatically
        let customBarButton = UIBarButtonItem(customView: customSettingButton)
        
        // assing custom rightbarbutton on navigation item
        navigationItem.setRightBarButtonItem(customBarButton, animated: true)
        
        
        
    }
    
    
//______________________________________(Loading profile pic, username and subtitle)________________________________________
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        FIRDatabase.database().reference().child("users").child(User.currentUserUid()!).observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            // get user information as Dictionary
            let userDictionary: [String:String]? = snapshot.value as? [String:String]
            
            // get profilePicture
            if let profileImage = userDictionary!["profilePicture"]{
                let url = NSURL(string:profileImage)
                NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
                    (data, response, error)in
                    
                    if error != nil{
                        print(error)
                        return
                    }
                    
                    let image = UIImage(data: data!)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.profileImageView.image = image
                    })
                    
                }).resume()
            }else{
            return
            }
            
            //get username
            self.username = userDictionary?["username"]
            self.nameTextField.text = self.username
            
            self.subtitle = userDictionary?["subtitle"]
            self.titleTextField.text = self.subtitle
            
        })

    }
    
//____________________________________________(Uploading Profile Image)_____________________________________________________
    
    func selectProfileImage () {
    let picker = UIImagePickerController ()
        picker.delegate = self
        picker.allowsEditing = true
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        var selectedImageFromPicker : UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            
            profileImageView.image = selectedImage
            let storageRef = FIRStorage.storage().reference()
            let userRef = storageRef.child("profilePicture").child(User.currentUserUid()!)
            
            if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!) {
            
                userRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil{
                        print(error)
                        return
                    } else {
                        if let imageURL = metadata?.downloadURLs?.first {
                            FIRDatabase.database().reference().child("users").child(User.currentUserUid()!).child("profilePicture").setValue(imageURL.absoluteString)
                            
                        }
                    }
                })
                
            }
            
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func openSetting(){
        
        performSegueWithIdentifier("settingSegue", sender: nil)
        
    }
}
////____________________________________________(Collection View Section)______________________________________________________
//
//    let imageRef = FIRDatabase.database().reference().child("users").child(User.currentUserUid()!).child("images")
//    var imageArray = [String]()
////    imageRef.observeEventType(.Value, withBlock: {snapshot in
////        imageArray = snapshot.value
////        
////     })
////
////func callImages(<#parameters#>) -> <#return type#> {
////    <#function body#>
////}
//
//
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//    




