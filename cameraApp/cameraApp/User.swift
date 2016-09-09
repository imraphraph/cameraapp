//
//  User.swift
//  cameraApp
//
<<<<<<< HEAD
//  Created by Bryan Lee on 09/09/2016.
=======
//  Created by Raphael Lim on 9/09/2016.
>>>>>>> 94420d7cb502f4515bfb0bd8e115138e7a7b36c2
//  Copyright © 2016 Raphael Lim. All rights reserved.
//

import Foundation
<<<<<<< HEAD
import FirebaseDatabase


class Member{
    var uid: String
    var email: String
    var username: String
  
    
    init?(snapshot: FIRDataSnapshot){
        
        guard let dict = snapshot.value as? [String: AnyObject] else { return nil }
        
        uid = snapshot.key
        
        if let dictEmail = dict["email"] as? String{
            self.email = dictEmail
        }else{
            self.email = ""
        }
        if let dictUsername = dict["username"] as? String{
            self.username = dictUsername
        }else{
            self.username = ""
        }
    }
    
}
=======

class User :NSObject {

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
>>>>>>> 94420d7cb502f4515bfb0bd8e115138e7a7b36c2
