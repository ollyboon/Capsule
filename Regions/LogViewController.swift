//
//  LogViewController.swift
//  Capsule
//
//  Created by Olly  on 07/01/2016.
//  Copyright © 2016 Oliver Boon (i7263244). All rights reserved.
//

import UIKit

class LogViewController: UIViewController {
    
    var locationsArray: [MyLocation]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Fragments Log"
        
        
        
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showData" {
            let vc = segue.destinationViewController as! DataViewController
            vc.myLocation = sender as! MyLocation
        }
    }
    
    
    
}

extension LogViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        let location = locationsArray[indexPath.row]
        
        let titleLabel = cell?.viewWithTag(1) as! UILabel
        titleLabel.text = location.identifier
        if location.isFound {
            cell?.accessoryType = .Checkmark
        }
        
        cell?.backgroundColor = UIColor.clearColor()
        
        return cell!
    }
    
}

extension LogViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let location  = locationsArray[indexPath.row]
        if location.regionDistance > 51 {
            return 0
        }

        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let location  = locationsArray[indexPath.row]
        if location.isFound {
            performSegueWithIdentifier("showData", sender: location)
        }
    }
    
}
