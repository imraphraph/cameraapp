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
import SDWebImage

class CameraViewController: UIViewController, FusumaDelegate {
    
    var base64String: NSString!
    var cameraShown:Bool = false
    var tempImage = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        if !cameraShown{
            let fusuma = FusumaViewController()
            fusuma.delegate = self
            fusuma.hasVideo = true // If you want to let the users allow to use video.
            self.presentViewController(fusuma, animated: true, completion: {
                self.cameraShown = true
            })
        }
    }
    
    
    func fusumaImageSelected(image: UIImage) {
        
        print("Image selected")
        
        self.tempImage = image
        
        performSegueWithIdentifier("imageCaptionSegue", sender: self)        
        self.cameraShown = false
        
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

        performSegueWithIdentifier("unwindToHomeTabBar", sender: self)
        self.cameraShown = false
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "imageCaptionSegue"){
        let nextScene =  segue.destinationViewController as! ImageCaptionViewController
        nextScene.selectedImage = self.tempImage
        }
    }
    

}
