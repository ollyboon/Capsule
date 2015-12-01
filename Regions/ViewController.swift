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
    
    @IBOutlet weak var imagePier: UIImageView!
    
    let imageView = UIImageView()

    let locationManager = CLLocationManager()
    
    var locationsArray = [CLLocationCoordinate2D]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage.gifWithName("glitch")
        imageView.frame = CGRect(x: 0.0, y: 20.0, width: 400.0, height: 650.0)
        imageView.alpha = 0
        view.addSubview(imageView)
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        myMap.setUserTrackingMode(.Follow, animated: true)
    
        //Barrier 1
        //let bournemouthPier = CLLocationCoordinate2D(latitude: 50.716098, longitude: -1.875780)
        //let bournemouthPierRegion = CLCircularRegion(center: bournemouthPier, radius: 25, identifier: "glitch")
        //locationManager.startMonitoringForRegion(bournemouthPierRegion)
        
        //Barrier 2
        let Barrier2 = CLLocationCoordinate2D(latitude: 50.716098, longitude: -1.875780)
        let Barrier2Region = CLCircularRegion(center: Barrier2, radius: 20, identifier: "splash")
        locationManager.startMonitoringForRegion(Barrier2Region)
        locationsArray.append(Barrier2)
        
        //Barrier 3
        //let Barrier3 = CLLocationCoordinate2D(latitude: 50.716098, longitude: -1.875780)
        //let Barrier3Region = CLCircularRegion(center: Barrier3, radius: 3, identifier: "glitch")
        //locationManager.startMonitoringForRegion(Barrier3Region)
        
        
        let boscombePier = CLLocationCoordinate2D(latitude: 50.719914, longitude: -1.843552)
        let boscombePierRegion = CLCircularRegion(center: boscombePier, radius: 20, identifier: "protected")
        locationManager.startMonitoringForRegion(boscombePierRegion)
        locationsArray.append(boscombePier)
    
        
    }


}


extension ViewController: CLLocationManagerDelegate {
    
    //let newLocation = CLLocationCoordinate2D(latitude: 50.716098, longitude: -1.875780)
    //let newLocation = 
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocation = locations.last
        
        if let newLocation = newLocation {
            
            for location in locationsArray {
                print(newLocation.distanceFromLocation(CLLocation(latitude: location.latitude, longitude: location.longitude)))
            }
            
        }
        
    }
    
    
  
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {

        //imageView.alpha = 0.5
        
        imageView.alpha = 0
        UIView.animateWithDuration(1.0) {
            self.imageView.alpha = 0.5
        }
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        imageView.alpha = 0.5
        UIView.animateWithDuration(1.0) {
            self.imageView.alpha = 0
        }
    }
    
    
}