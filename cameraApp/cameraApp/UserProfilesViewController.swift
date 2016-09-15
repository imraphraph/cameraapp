//
//  UserProfilesViewController.swift
//  cameraApp
//
//  Created by Raphael Lim on 15/09/2016.
//  Copyright © 2016 Raphael Lim. All rights reserved.
//

import UIKit

class UserProfilesViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameTextView: UILabel!
    @IBOutlet weak var userTitleTextView: UILabel!
    
    
    
    var externalUserID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
        profileImageView.userInteractionEnabled = true
        

    }
    
    func selectProfileImage () {
    
    }

    @IBAction func followButton(sender: UIButton) {
    }
    
    
}
