//
//  HomeTabBarTableViewController.swift
//  
//
//  Created by Bryan Lee on 09/09/2016.
//
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeTabBarTableViewController: UITableViewController {
    
    var usernames = [""]
    var userids = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            FIRDatabase.database().reference().child(User.currentUserUid).child("users").observeEventType(.Value, withBlock: { (snapshot) in
                if let userDict = snapshot.value as? [String: AnyObject]{
                    if let username = userDict["username"] as? String{
                        self.usernames.append(username)
 
            
                    }
                }
            })
    }


//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        
//        return 2
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.usernames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell", forIndexPath: indexPath)

        cell.textLabel!.text = self.usernames[indexPath.row]
        
        return cell
    }
    

 

}
