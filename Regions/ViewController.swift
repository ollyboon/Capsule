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
    
    let imageView = UIImageView()
    
    let FirstLocationImg = UIImageView()
    
    let locationManager = CLLocationManager()
    
    var locationsArray = [MyLocation]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage.gifWithName("glitch")
        imageView.frame = CGRect(x: 0.0, y: 20.0, width: 400.0, height: 650.0)
        imageView.alpha = 0
        view.addSubview(imageView)
        
        FirstLocationImg.image = UIImage(named: "cache1.png")
        FirstLocationImg.frame = CGRect(x: 0.0, y: 5.0, width: 375.0, height: 650.0)
        FirstLocationImg.alpha=0
        view.addSubview(FirstLocationImg)
        
        
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        myMap.setUserTrackingMode(.Follow, animated: true)
        
        //Barrier
        let Barrier1 = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.716098, longitude: -24.875780), regionDistance: 10, identifier: "Barrier1")
        locationsArray.append(Barrier1)
        
        let Barrier2 = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.716098, longitude: -1.875780), regionDistance: 10, identifier: "Barrier2")
        locationsArray.append(Barrier2)
    
        for location in locationsArray {
            locationManager.startMonitoringForRegion(location.region)
        }
    }


}


extension ViewController: CLLocationManagerDelegate {
    
    //let newLocation = CLLocationCoordinate2D(latitude: 50.716098, longitude: -1.875780)
    //let newLocation = 
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocation = locations.last
        
        if let newLocation = newLocation {
            
            for location in locationsArray {
                location.distance = newLocation.distanceFromLocation(CLLocation(latitude: location.coord.latitude, longitude: location.coord.longitude))
            }
            
            locationsArray.sortInPlace { return $0.distance > $1.distance }
            
            print(locationsArray.first!.identifier)
            
            if locationsArray.first!.distance < 100 {
                
            }
            
        }
        
    }
    
    
  
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
            
            imageView.alpha = 0
            UIView.animateWithDuration(1.0) {
                self.imageView.alpha = 0.5
            }
            
        
        if  region.identifier == "FirstLocation" {
            
            FirstLocationImg.alpha = 0
            UIView.animateWithDuration(2.0) {
                self.FirstLocationImg.alpha = 1
            }
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