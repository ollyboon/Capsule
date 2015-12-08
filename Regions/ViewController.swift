//
//  ViewController.swift
//  Regions
//
//  Created by Oliver Boon (i7263244) on 29/10/2015.
//  Copyright © 2015 Oliver Boon (i7263244). All rights reserved.
//

import UIKit 
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var myMap: MKMapView!
    
    @IBOutlet weak var Dial: UIImageView!
    
    @IBOutlet weak var Unknown: UIImageView!
    
    @IBAction func showAlert() {
        
        let alertController = UIAlertController(title: "How to play", message: "Explore the bourenmouth seafront region on foot to discover clues" , preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    let imageView = UIImageView()
    
    let FirstLocationImg = UIImageView()
    
    let locationManager = CLLocationManager()
    
    var locationsArray = [MyLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //LOAD SUBVIEW IMAGES IN BACKGROUND
        
        imageView.image = UIImage.gifWithName("glitch")
        imageView.frame = CGRect(x: 0.0, y: 20.0, width: 400.0, height: 650.0)
        imageView.alpha = 0
        view.addSubview(imageView)
        
        FirstLocationImg.image = UIImage(named: "cache1.png")
        FirstLocationImg.frame = CGRect(x: 0.0, y: 5.0, width: 375.0, height: 650.0)
        FirstLocationImg.alpha=0
        view.addSubview(FirstLocationImg)
        
        //ANIMATIONS
        
        let fullRotation = CGFloat(M_PI * 2)
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.rotation.z"
        animation.duration = 6
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.repeatCount = Float.infinity
        animation.values = [fullRotation, fullRotation/2, fullRotation*3/4, fullRotation]
        
        Dial.layer.addAnimation(animation, forKey: "rotate")
        
        
        
        UIView.animateWithDuration(10.0, delay:0, options: [.Repeat, .Autoreverse], animations: {
         
        self.Unknown.alpha = 1
        self.Unknown.alpha = 0.2
        self.Unknown.alpha = 1

            
        }, completion: nil)
        
        //HOW TO PLAY ALERT
        
        let alertController = UIAlertController(title: "Default Style", message: "A standard alert.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // ...
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }

        //LOCATIONS
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        myMap.setUserTrackingMode(.Follow, animated: true)
        
        
        //BOURNMOUTH PIER
        let Barrier1 = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.716098, longitude: -1.875780), regionDistance: 200, identifier: "Barrier1")
        locationsArray.append(Barrier1)
        
        let Barrier2 = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.716098, longitude: -1.875780), regionDistance: 50, identifier: "Barrier2")
        locationsArray.append(Barrier2)
        
        let Home = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.734646, longitude: -1.877253), regionDistance: 20, identifier: "Home")
        locationsArray.append(Home)
    
        for location in locationsArray {
            locationManager.startMonitoringForRegion(location.region)
        }
    }


}





extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocation = locations.last
        
        if let newLocation = newLocation {
            
            for location in locationsArray {
                location.distance = newLocation.distanceFromLocation(CLLocation(latitude: location.coord.latitude, longitude: location.coord.longitude)) / 2001
            }
            
            //var  = min(0, 200) //max(1, 0)
            
            locationsArray.sortInPlace { return $0.distance < $1.distance }
            
            print(locationsArray.first!.identifier)
            print(locationsArray.first!.distance)
            
        }
        
    }
    
    
  
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
    
        
        if  region.identifier == "Barrier2" {
            
            FirstLocationImg.alpha = 0
            UIView.animateWithDuration(2.0) {
                self.FirstLocationImg.alpha = 1
            }
        }
        
        //OPACITY OF GLITCH
        
        if locationsArray.first!.distance < 200 {
            imageView.alpha = CGFloat(locationsArray.first!.distance)
        }
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        
        FirstLocationImg.alpha = 1
        UIView.animateWithDuration(1.0) {
            self.FirstLocationImg.alpha = 0
        }
        
    }
    
    
}