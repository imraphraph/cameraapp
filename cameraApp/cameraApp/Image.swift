//
//  Image.swift
//  cameraApp
//
//  Created by Hahaboy on 13/09/2016.
//  Copyright © 2016 Raphael Lim. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Image :NSObject {
    
    var time: Double?
    var imgurl: String?
    var username: String?
    var caption: String?
    var pImage: String?
    
    init?(snapshot: FIRDataSnapshot){
        
        guard let dict = snapshot.value as? [String: AnyObject] else { return nil }
        
        if let dictTime = dict["created_at"] as? Double{
            self.time = dictTime
        }else{
            self.time = 0.0
        }
        
        if let dictImgurl = dict["imgurl"] as? String{
            self.imgurl = dictImgurl
        }else{
            self.imgurl = ""
        }
        
        if let dictUsername = dict["userUID"] as? String{
            self.username = dictUsername
        }else{
            self.username = ""
        }
        
        if let dictCaption = dict["caption"] as? String{
            self.caption = dictCaption
        }else{
            self.caption = ""
        }
        
    }
    
    
}