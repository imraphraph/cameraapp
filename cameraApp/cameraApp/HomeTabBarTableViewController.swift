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
        self.tableView.rowHeight = 385
        
        DataService.imageRef.observeEventType(.ChildAdded, withBlock: { imageSnapshot in
            if let image = Image(snapshot: imageSnapshot){
                
                
                DataService.userRef.child(image.username!).observeEventType(.Value, withBlock: { userSnapshot in
                    if let user = User(snapshot: userSnapshot){
                        image.username = user.username
                        image.pImage = user.pImage
                        self.listOfImages.append(image)

                    }
                })
                
                
                
                //self.listOfImages.append(image)
                self.tableView.reloadData()
                
            }
        })
    }
    
    
    @IBAction func unwindToHomeTabBar(segue: UIStoryboardSegue) {
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.listOfImages.count
    }

    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("SectionCell")
        
        let user = self.listOfImages[section]
        
        headerCell?.textLabel?.text = user.username
        
        if let userImageUrl = user.pImage{
            
            let url = NSURL(string: userImageUrl)
            
            headerCell!.imageView!.sd_setImageWithURL(url)
            headerCell?.imageView!.layer.cornerRadius = (headerCell?.imageView!.frame.size.width)! / 2
            headerCell?.imageView!.clipsToBounds = true
        }
        
        return headerCell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:StaticHomeCell = tableView.dequeueReusableCellWithIdentifier("HomeCell") as! StaticHomeCell
        
        let user = listOfImages[indexPath.section]
        
        cell.captionLabel.text = user.caption
        
        if let userImageUrl = user.imgurl{
                        
            let url = NSURL(string: userImageUrl)
            let frame = cell.helloImageView.frame
            cell.helloImageView.sd_setImageWithURL(url)
            cell.helloImageView.frame = frame
            cell.likeButton.tag = indexPath.section
        }
        
        return cell
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("pressed on \(indexPath) cell")
    }

    
}
