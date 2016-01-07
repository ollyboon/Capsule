//
//  dataviewcontroller.swift
//  Capsule
//
//  Created by Olly  on 07/01/2016.
//  Copyright © 2016 Oliver Boon (i7263244). All rights reserved.
//


import UIKit

class DataViewController: UIViewController {
    
    var myLocation: MyLocation!

    @IBOutlet weak var dataImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(myLocation.identifier)
        
        dataImage.image = UIImage (named: myLocation.identifier)
        
        
        
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}


