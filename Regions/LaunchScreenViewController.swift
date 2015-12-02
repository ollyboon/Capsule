//
//  LaunchScreenViewController.swift
//  Regions
//
//  Created by Olly  on 02/12/2015.
//  Copyright © 2015 Oliver Boon (i7263244). All rights reserved.
//

import Foundation
import UIKit

class LaunchScreenViewController: UIViewController {
    
    
    let imageView = UIImageView()
    let Glitchimg = UIImageView()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage.gifWithName("capglitch")
        imageView.frame = CGRect(x: 0.0, y: 20.0, width: 400.0, height: 650.0)
        imageView.alpha = 0.5
        view.addSubview(imageView)
        
        Glitchimg.image = UIImage(named: "splash-1.png")
        Glitchimg.frame = CGRect(x: 0.0, y: 5.0, width: 375.0, height: 650.0)
        Glitchimg.alpha=1
        view.addSubview(Glitchimg)
        
    }
    
    

}
