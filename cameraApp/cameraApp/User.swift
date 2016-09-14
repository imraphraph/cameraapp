//
//  User.swift
//  cameraApp
//
//  Created by Raphael Lim on 9/09/2016.
//  Copyright © 2016 Raphael Lim. All rights reserved.
//

import Foundation
import FirebaseDatabase

class User{

    var email: String
    var username: String
    var images: String

    init?(snapshot: FIRDataSnapshot){

        guard let dict = snapshot.value as? [String: AnyObject] else { return nil }

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

        if let dictImage = dict["images"] as? String{
            self.images = dictImage
        }else{
            self.images = ""
        }

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
