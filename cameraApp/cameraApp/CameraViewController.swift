//
//  CameraViewController.swift
//  cameraApp
//
//  Created by Hahaboy on 08/09/2016.
//  Copyright © 2016 Raphael Lim. All rights reserved.
//

import UIKit
import Fusuma
import Firebase
import FirebaseDatabase
import FirebaseStorage

class CameraViewController: UIViewController, FusumaDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    var base64String: NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fusuma = FusumaViewController()
        fusuma.delegate = self
        fusuma.hasVideo = true // If you want to let the users allow to use video.
        self.presentViewController(fusuma, animated: true, completion: nil)
        
        
    }
    
    
    func fusumaImageSelected(image: UIImage) {
        
        print("Image selected")
        
        
        
//        let uniqueImgName = NSUID().UUIDString
        let storageRef = FIRStorage.storage().reference().child("test.png")
        
        let selectedImage = UIImagePNGRepresentation(image)!
            storageRef.putData(selectedImage, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    print(error)
                    return
                }
                
                
                let ref = FIRDatabase.database().reference()
                let currentUserRef = ref.child("images").childByAutoId()
                if let imageURL = metadata?.downloadURL()?.absoluteString{
                    let value = ["imgurl":imageURL]
                    currentUserRef.setValue(value)
                    
                }
                
            })
        
//        storageRef.dataWithMaxSize(25 * 1024 * 1024, completion: { (data, error) -> Void in
//            let image = UIImage(data: data!)
//            self.imageView.image = image!
        
            //store in array to display
//            self.messages.append(chatMessage)
//            self.tableView.reloadData()
//            self.scrollToBottom()
//        })
        
    
    }
    
    // Return the image but called after is dismissed.
    func fusumaDismissedWithImage(image: UIImage) {
        
        print("Called just after FusumaViewController is dismissed.")
        
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: NSURL) {
        
        print("Called just after a video has been selected.")
    }
    
    // When camera roll is not authorized, this method is called.
    func fusumaCameraRollUnauthorized() {
        
        print("Camera roll unauthorized")
    }
    
    func fusumaClosed() {
        print("go home")
    }
    

}
