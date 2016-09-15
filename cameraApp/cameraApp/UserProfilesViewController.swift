//
//  UserProfilesViewController.swift
//  cameraApp
//
//  Created by Raphael Lim on 15/09/2016.
//  Copyright © 2016 Raphael Lim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class UserProfilesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var feedCollectionView: UICollectionView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameTextView: UILabel!
    @IBOutlet weak var userTitleTextView: UILabel!
    
    var profileImageUrl : String?
    var username: String?
    var subtitle: String?
    
    var externalUserID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
        profileImageView.userInteractionEnabled = true
        

    }
    
    func selectProfileImage () {
        let picker = UIImagePickerController ()
        picker.delegate = self
        picker.allowsEditing = true
        presentViewController(picker, animated: true, completion: nil)
    }


    @IBAction func followButton(sender: UIButton) {
    }
    
    
//_____________________________________(Loading images etc)_________________________________________________________
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        FIRDatabase.database().reference().child("users").child(externalUserID!).observeSingleEventOfType(.Value, withBlock: { snapshot in
            
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
            self.userNameTextView.text = self.username
            
            self.subtitle = userDictionary?["subtitle"] as? String
            self.userTitleTextView.text = self.subtitle
            
        })
        
    }

    
//____________________________________(Collection View Section)______________________________________________________
    
    var images : [UIImage] = []
    func retrieveImageFromDatabse(){
        FIRDatabase.database().reference().child("users").child(externalUserID!).child("images").observeEventType(.ChildAdded, withBlock: { (snapshot) in
            
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





