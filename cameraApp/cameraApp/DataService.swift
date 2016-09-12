//
//  DataService.swift
//  cameraApp
//
//  Created by Bryan Lee on 12/09/2016.
//  Copyright © 2016 Raphael Lim. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct DataService{
    
    static var rootRef = FIRDatabase.database().reference()
    static var userRef = FIRDatabase.database().reference().child("users")
}