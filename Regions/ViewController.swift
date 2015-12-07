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
        
        
        
        UIView.animateWithDuration(4.0, delay:3, options: [.Repeat, .Autoreverse], animations: {
         
        self.Unknown.alpha = 1
        self.Unknown.alpha = 0.2
                    
        }, completion: nil)
        
        //NOTIFICATION 
        
        let alert = UIAlertView()
        alert.title = "How to play"
        alert.message = "Explore the bourenmouth seafront region on foot to discover clues"
        alert.addButtonWithTitle("Understood")
        alert.show()


        
        //LOCATIONS
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        myMap.setUserTrackingMode(.Follow, animated: true)
        
        //BOURNMOUTH PIER
        let Barrier1 = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.716098, longitude: -24.875780), regionDistance: 30, identifier: "Barrier1")
        locationsArray.append(Barrier1)
        
        let Barrier2 = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.716098, longitude: -1.875780), regionDistance: 10, identifier: "Barrier2")
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
                location.distance = newLocation.distanceFromLocation(CLLocation(latitude: location.coord.latitude, longitude: location.coord.longitude))
            }
            
            locationsArray.sortInPlace { return $0.distance > $1.distance }
            
            print(locationsArray.first!.identifier)
            print(locationsArray.first!.distance)
            
        }
        
    }
    
    
  
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
            
            imageView.alpha = 0
            UIView.animateWithDuration(1.0) {
                self.imageView.alpha = 0.5
            }
        
        if  region.identifier == "Home" {
            
            FirstLocationImg.alpha = 0
            UIView.animateWithDuration(2.0) {
                self.FirstLocationImg.alpha = 1
            }
        }
        
        //THIS IS THE BIT IM STUCK ON
        
        if locationsArray.first!.distance < 50 {
            //imageView.alpha = locationsArray.first!.distance
        }
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        imageView.alpha = 0.5
        UIView.animateWithDuration(1.0) {
            self.imageView.alpha = 0
        }
        
        FirstLocationImg.alpha = 1
        UIView.animateWithDuration(1.0) {
            self.FirstLocationImg.alpha = 0
        }
        
    }
    
    
}

extension UIView {
    
    
}