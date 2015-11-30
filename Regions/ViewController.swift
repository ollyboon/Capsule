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
    
    let locationManager = CLLocationManager ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let Barrier2Region = CLCircularRegion(center: Barrier2, radius: 10, identifier: "splash")
        locationManager.startMonitoringForRegion(Barrier2Region)
        
        //Barrier 3
        //let Barrier3 = CLLocationCoordinate2D(latitude: 50.716098, longitude: -1.875780)
        //let Barrier3Region = CLCircularRegion(center: Barrier3, radius: 3, identifier: "glitch")
        //locationManager.startMonitoringForRegion(Barrier3Region)
        
        
        let boscombePier = CLLocationCoordinate2D(latitude: 50.719914, longitude: -1.843552)
        let boscombePierRegion = CLCircularRegion(center: boscombePier, radius: 20, identifier: "protected")
        locationManager.startMonitoringForRegion(boscombePierRegion)
        
        
        
        
    }


}


extension ViewController: CLLocationManagerDelegate {
    
    //let newLocation = CLLocationCoordinate2D(latitude: 50.716098, longitude: -1.875780)
    //let newLocation = 
    
  
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
       
           // imagePier.image = UIImage(named: region.identifier)
            //imagePier.alpha = 0.5
        
        //GIF Test
        let glitchGif = UIImage.gifWithName("glitch")
        let imageView = UIImageView(image: glitchGif)
        imageView.frame = CGRect(x: 0.0, y: 20.0, width: 400.0, height: 650.0)
        imageView.alpha = CGFloat(0.5)
        
        view.addSubview(imageView)
        
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {

           // imagePier.image = nil
        
    }
    
    
}