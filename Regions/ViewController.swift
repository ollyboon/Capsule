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
import AudioToolbox

class ViewController: UIViewController {
    
    @IBOutlet weak var myMap: MKMapView!
    
    @IBOutlet weak var Dial: UIImageView!
    
    @IBOutlet weak var Unknown: UIImageView!
    
    @IBAction func showAlert() {
        
        let alertController = UIAlertController(title: "How to play", message: "Explore the bourenmouth seafront region on foot to discover clues. Use the Log View to see unlocked data fragments " , preferredStyle: .Alert)
        
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
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 75.0/255.0, green: 77.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor(red: 254.0/255.0, green: 194.0/255.0, blue: 0.0/255.0, alpha: 1.0)


        
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
        

        //LOCATIONS
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        myMap.setUserTrackingMode(.Follow, animated: true)
        
        
        //BOURNMOUTH PIER
        let Barrier1 = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.716098, longitude: -1.875780), regionDistance: 200, identifier: "Barrier1")
        locationsArray.append(Barrier1)
        
        let Seafront = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.716098, longitude: -1.875780), regionDistance: 50, identifier: "Seafront")
        locationsArray.append(Seafront)
        
//        //HOME
//        let Home = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.734646, longitude: -1.877253), regionDistance: 20, identifier: "Home")
//        locationsArray.append(Home)
        
        let Barrier2 = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.715387, longitude: -1.87804), regionDistance: 200, identifier: "Barrier2")
        locationsArray.append(Barrier2)
        
        let Oceanarium = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.715387, longitude: -1.87804), regionDistance: 50, identifier: "Oceanarium")
        locationsArray.append(Oceanarium)
        
        let Barrier3 = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.719517, longitude: -1.843064), regionDistance: 200, identifier: "Barrier3")
        locationsArray.append(Barrier3)
        
        let Boscombe = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.719517, longitude: -1.843064), regionDistance: 50, identifier: "Boscombe")
        locationsArray.append(Boscombe)
        
        let Barrier4 = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.719796, longitude: -1.879563), regionDistance: 200, identifier: "Barrier4")
        locationsArray.append(Barrier4)
        
        let Gardens = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.719796, longitude: -1.879563), regionDistance: 50, identifier: "Gardens")
        locationsArray.append(Gardens)
        
        
    
        for location in locationsArray {
            locationManager.startMonitoringForRegion(location.region)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Log" {
            let vc = segue.destinationViewController as! LogViewController
            vc.locationsArray = locationsArray
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
            
          
            
            locationsArray.sortInPlace { return $0.distance < $1.distance }
            
            print(locationsArray.first!.identifier)
            //print(locationsArray.first!.distance)
            
            switch locationsArray.first!.distance {
            case 0..<49:
                imageView.alpha = 0.8
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.85
                }
            case 50..<59:
                imageView.alpha = 0.75
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.8
                }
            case 60..<69:
                imageView.alpha = 0.7
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.75
                }
            case 70..<79:
                imageView.alpha = 0.65
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.7
                }
            case 80..<89:
                imageView.alpha = 0.6
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.65
                }
            case 90..<99:
                imageView.alpha = 0.55
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.6
                }
            case 100..<109:
                imageView.alpha = 0.5
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.55
                }
            case 110..<119:
                imageView.alpha = 0.45
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.5
                }
            case 120..<129:
                imageView.alpha = 0.4
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.45
                }
            case 130..<139:
                imageView.alpha = 35
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.4
                }
            case 140..<149:
                imageView.alpha = 0.3
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.35
                }
            case 150..<159:
                imageView.alpha = 0.25
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.3
                }
            case 160..<169:
                imageView.alpha = 0.2
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.25
                }
            case 170..<179:
                imageView.alpha = 0.15
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.2
                }
            case 180..<189:
                imageView.alpha = 0.1
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.15
                }
            case 190..<200:
                imageView.alpha = 0
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.1
                }
                
                
            default:
                imageView.alpha = 0
            }
            
        }
        
    }
    
    
  
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        for location in locationsArray {
            if region.identifier == location.identifier {
                location.isFound = true
            }
            
            if location.regionDistance > 51 {
                location.isFound = false
            }
        }
        
        
        if  region.identifier == "Seafront" {
            
            FirstLocationImg.alpha = 0
            UIView.animateWithDuration(4.0) {
                self.FirstLocationImg.alpha = 1
                
            }
            
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            
            
        }
        
        
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        
        FirstLocationImg.alpha = 0

        imageView.alpha = 0
        
    }
    
    
}