//
//  User.swift
//  cameraApp
//
//  Created by Bryan Lee on 09/09/2016.
//  Copyright © 2016 Raphael Lim. All rights reserved.
//

import Foundation
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