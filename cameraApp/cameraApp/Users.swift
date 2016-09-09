//
//  Users.swift
//  cameraApp
//
//  Created by Bryan Lee on 09/09/2016.
//  Copyright © 2016 Raphael Lim. All rights reserved.
//

import Foundation

class User{
    
    static var currentUserUid: String{
        
        return NSUserDefaults.standardUserDefaults().objectForKey("userUID") as! String
    }
    
}