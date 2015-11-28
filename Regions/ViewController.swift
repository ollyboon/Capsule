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
    
        let bournemouthPier = CLLocationCoordinate2D(latitude: 50.716098, longitude: -1.875780)
        let bournemouthPierRegion = CLCircularRegion(center: bournemouthPier, radius: 20, identifier: "Bournemouth Pier")
        locationManager.startMonitoringForRegion(bournemouthPierRegion)
        
        
        let boscombePier = CLLocationCoordinate2D(latitude: 50.719914, longitude: -1.843552)
        let boscombePierRegion = CLCircularRegion(center: boscombePier, radius: 20, identifier: "Boscombe Pier")
        locationManager.startMonitoringForRegion(boscombePierRegion)
    }


}


extension ViewController: CLLocationManagerDelegate {
    
    
    
  
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
       
            imagePier.image = UIImage(named: region.identifier)
            imagePier.alpha = 0.2
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {

            imagePier.image = nil
    }
    
    
}