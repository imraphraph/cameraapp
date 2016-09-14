//
//  User.swift
//  cameraApp
//
//  Created by Raphael Lim on 9/09/2016.
//  Copyright © 2016 Raphael Lim. All rights reserved.
//

import Foundation

class User :NSObject {
    
    class func loadUserProfileImage (){
    
//        if let profileImageUrl = ProfileTabPageViewController.imageURL {
//        
//            let url = NSURl(string:profileImageUrl)
//            
//            NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
//            (data, response, error)in
//            
//                if error != nil{
//                print(error)
//                    return
//                }
//                
//            })
//            
//        }
        
            
        
    }

class func signIn (uid: String){
    //storing the uid of the person in the phone's default settings.
    NSUserDefaults.standardUserDefaults().setValue(uid, forKeyPath: "uid")
    
}

class func isSignedIn() -> Bool {
    
    if let _ = NSUserDefaults.standardUserDefaults().valueForKey("uid") as? String{
        return true
    }else {
        return false
    }
    
}

class func currentUserUid() -> String? {
    return NSUserDefaults.standardUserDefaults().valueForKey("uid") as? String
}

}
