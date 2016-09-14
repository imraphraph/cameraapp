//
//  StaticHomeCell.swift
//  
//
//  Created by Hahaboy on 13/09/2016.
//
//

import Foundation
import UIKit

class StaticHomeCell: UITableViewCell {
    
    var checker:Bool = true
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var helloImageView: UIImageView!

    @IBOutlet weak var nameLabelText: UILabel!
    
    @IBAction func onLikeButtonPressed(sender: UIButton) {
        
        if checker{
            if let image = UIImage(named: "filledheart") {
                self.likeButton.setImage(image, forState: .Normal)
                checker = false
            }
        }else{
            if let image = UIImage(named: "emptyheart") {
                self.likeButton.setImage(image, forState: .Normal)
                checker = true
            }
        }
        
    }
    
    @IBAction func onCommentButtonPressed(sender: AnyObject) {
        
        
        
    }
}