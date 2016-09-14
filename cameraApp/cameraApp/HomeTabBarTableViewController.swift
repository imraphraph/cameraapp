//
//  HomeTabBarTableViewController.swift
//  cameraApp
//
//  Created by Hahaboy on 09/09/2016.
//  Copyright © 2016 Raphael Lim. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage


class HomeTabBarTableViewController: UITableViewController {
    
    var listOfImages = [Image]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.estimatedRowHeight = 88.0
//        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        DataService.imageRef.observeEventType(.ChildAdded, withBlock: { imageSnapshot in
            if let image = Image(snapshot: imageSnapshot){
                self.listOfImages.append(image)
                self.tableView.reloadData()
            }
        })
    }
    
    
    @IBAction func unwindToHomeTabBar(segue: UIStoryboardSegue) {
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listOfImages.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:StaticHomeCell = tableView.dequeueReusableCellWithIdentifier("HomeCell") as! StaticHomeCell
        
        let user = listOfImages[indexPath.row]
        
        cell.nameLabelText.text = user.username
        
        if let userImageUrl = user.imgurl{
                        
            let url = NSURL(string: userImageUrl)
            let frame = cell.helloImageView.frame
            cell.helloImageView.sd_setImageWithURL(url)
            cell.helloImageView.frame = frame
        }
        
        return cell
    }
    
    
}
