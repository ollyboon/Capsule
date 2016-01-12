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
    //Sets up segue for clicking on table and going to next view controller with data fragments on.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showData" {
            let vc = segue.destinationViewController as! DataViewController
            vc.myLocation = sender as! MyLocation
        }
    }
    
    
    
}

extension LogViewController: UITableViewDataSource {
    //Creates rows on table from the number of items in locations array.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Takes the Names of each location and pastes them in their own cell on the table.
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        let location = locationsArray[indexPath.row]
        //Names the cell with the region identifier.
        let titleLabel = cell?.viewWithTag(1) as! UILabel
        titleLabel.text = location.identifier
        //if the region has been visited it adds a checkmark to indicate this.
        if location.isFound {
            cell?.accessoryType = .Checkmark
        }
        
        //Makes background colour of each cell transparent.
        cell?.backgroundColor = UIColor.clearColor()
        
        return cell!
    }
    
}

extension LogViewController: UITableViewDelegate {
    //This eesentially makes all of the regions that hold the GIF invisible in the table. As they are 200m radius I have told the table to ignore any region that is over 51m in radius.
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let location  = locationsArray[indexPath.row]
        if location.regionDistance > 51 {
            return 0
        }

        return 60
    }
    //If the location has been visited it allows the user to click on the item and sends it to the next view controller with "ShowData" Segue. The next view controller holds images of each data fragment.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let location  = locationsArray[indexPath.row]
        if location.isFound {
            performSegueWithIdentifier("showData", sender: location)
        }
    }
    
}
