//
//  HomePageViewController.swift
//  
//
//  Created by Bryan Lee on 12/09/2016.
//
//

import UIKit

class HomePageViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var members = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        DataService.rootRef.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell")!
        
        let member = members[indexPath.row]
        cell.textLabel?.text = member
        
        return cell
        
    }
    
    
    
    
    

}
