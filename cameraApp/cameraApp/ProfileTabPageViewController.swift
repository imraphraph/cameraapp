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



class ProfileTabPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var titleTextField: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var feedCollectionView: UICollectionView!
    
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
        
    
        retrieveImageFromDatabse()
//        feedCollectionView.dataSource = self
//        feedCollectionView.delegate = self
    }
    
    
//______________________________________(Loading profile pic, username and subtitle)________________________________________
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        FIRDatabase.database().reference().child("users").child(User.currentUserUid()!).observeSingleEventOfType(.Value, withBlock: { snapshot in
            
                // get user information as Dictionary
                let userDictionary: [String:AnyObject]? = snapshot.value as? [String:AnyObject]
                
                // get profilePicture
                if let profileImage = userDictionary?["profilePicture"] as? String {
                    
                    let url = NSURL(string:profileImage)
                    NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
                        (data, response, error) in
                        
                        if error != nil{
                            print(error)
                            return
                        }
                        
                        let image = UIImage(data: data!)
                        dispatch_async(dispatch_get_main_queue(), {
                            self.profileImageView.image = image
                        })
                        
                    }).resume()
                }
                //get username
                self.username = userDictionary?["username"] as? String
                self.nameTextField.text = self.username
                
                self.subtitle = userDictionary?["subtitle"] as? String
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

//____________________________________________(Collection View Section)______________________________________________________

//    var imageArray = [String]()
    var images : [UIImage] = []
    func retrieveImageFromDatabse(){
        FIRDatabase.database().reference().child("users").child(User.currentUserUid()!).child("images").observeEventType(.ChildAdded, withBlock: { (snapshot) in
            
            FIRDatabase.database().reference().child("images").child(snapshot.key).observeSingleEventOfType(.Value, withBlock: { snapshot in
                    guard let snapshotDictionary = snapshot.value as? [String:AnyObject] else { return }
                    if let imageURL = snapshotDictionary["imgurl"] as? String {
                        let url = NSURL(string:imageURL)
                        NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
                            (data, response, error) in
                            
                            if error != nil{
                                print(error)
                                return
                            }
                            
                            if let image = UIImage(data: data!){
                                self.images.append(image)
                                dispatch_async(dispatch_get_main_queue(), { 
                                    self.feedCollectionView.reloadData()
                                })
                            }
                            
                        }).resume()
                    }
                })
            })
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenWidth = self.view.frame.size.width
        let itemWidth = screenWidth / 3
        return CGSizeMake(itemWidth, itemWidth)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }


    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! ImageCell
        let image = images[indexPath.row]
        cell.imageView.image = image
        return cell
    }


}


