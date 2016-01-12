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
import AVFoundation

class ViewController: UIViewController {
    
    //Outlets for map, dial and Unknown element image (now not in use)
    
    @IBOutlet weak var myMap: MKMapView!
    
    @IBOutlet weak var Dial: UIImageView!
    
    @IBOutlet weak var Unknown: UIImageView!
    
    //outlet for ? alert.
    
    @IBAction func showAlert() {
        
        let alertController = UIAlertController(title: "How to play", message: "Explore the bourenmouth seafront region on foot to discover clues. Use the Log View to see unlocked data fragments " , preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    //lets and variables for defining names
    
    let imageView = UIImageView()
    
    let Fragment1Img = UIImageView()
    
    let Fragment2Img = UIImageView ()
    
    let Fragment3Img = UIImageView ()
    
    let Fragment4Img = UIImageView ()
    
    let locationManager = CLLocationManager()
    
    var locationsArray = [MyLocation]()
    
    var visitedArray = [String]()
    
    var audioPlayer = AVAudioPlayer()
    
    var audioPlayer1 = AVAudioPlayer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Defining colour of navigation bar.
        
        
        //Plays radio tuning sound in background
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 75.0/255.0, green: 77.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor(red: 254.0/255.0, green: 194.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        let myFilePathString = NSBundle.mainBundle().pathForResource("Static1", ofType: "mp3")
        
        if let myFilePathString = myFilePathString {
            
            let myFilePathURL = NSURL (fileURLWithPath: myFilePathString)
            
            do{
             try audioPlayer = AVAudioPlayer(contentsOfURL: myFilePathURL)
                
              audioPlayer.play()
               audioPlayer.numberOfLoops = -1
                print("Playing")
                
            }catch
            {
                print("error")
            }
        }


        
        //LOAD SUBVIEW IMAGES IN BACKGROUND
        
        imageView.image = UIImage.gifWithName("glitch")
        imageView.frame = CGRect(x: 0.0, y: 20.0, width: 400.0, height: 650.0)
        imageView.alpha = 0
        view.addSubview(imageView)
        
        Fragment1Img.image = UIImage(named: "Seafront.png")
        Fragment1Img.frame = CGRect(x: 0.0, y: 5.0, width: 375.0, height: 650.0)
        Fragment1Img.alpha=0
        view.addSubview(Fragment1Img)
        
        Fragment2Img.image = UIImage(named: "Oceanarium.png")
        Fragment2Img.frame = CGRect(x: 0.0, y: 5.0, width: 375.0, height: 650.0)
        Fragment2Img.alpha=0
        view.addSubview(Fragment2Img)
        
        Fragment3Img.image = UIImage(named: "Boscombe.png")
        Fragment3Img.frame = CGRect(x: 0.0, y: 5.0, width: 375.0, height: 650.0)
        Fragment3Img.alpha=0
        view.addSubview(Fragment3Img)
        
        Fragment4Img.image = UIImage(named: "Final.png")
        Fragment4Img.frame = CGRect(x: 0.0, y: 5.0, width: 375.0, height: 650.0)
        Fragment4Img.alpha=0
        view.addSubview(Fragment4Img)
        
        //ANIMATIONS
        //Defining Rotation animation
        let fullRotation = CGFloat(M_PI * 2)
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.rotation.z"
        animation.duration = 6
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.repeatCount = Float.infinity
        animation.values = [fullRotation, fullRotation/2, fullRotation*3/4, fullRotation]
        
        Dial.layer.addAnimation(animation, forKey: "rotate")
        
        //LOCATIONS
        //Adding authorisation request, constant location updating and tracking on map for user.
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        myMap.setUserTrackingMode(.Follow, animated: true)
        
        
        
        //Defining the locations with Custom object "MyLocation"
        let Barrier1 = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.715591, longitude: -1.875529), regionDistance: 200, identifier: "Barrier1")
        locationsArray.append(Barrier1)
        
        let Seafront = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.715591, longitude: -1.875529), regionDistance: 50, identifier: "Seafront")
        locationsArray.append(Seafront)
        
        let Barrier2 = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.713689, longitude: -1.886601), regionDistance: 100, identifier: "Barrier2")
        locationsArray.append(Barrier2)
        
        let Oceanarium = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.713689, longitude: -1.886601), regionDistance: 50, identifier: "Oceanarium")
        locationsArray.append(Oceanarium)
        
        let Barrier3 = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.719517, longitude: -1.843064), regionDistance: 100, identifier: "Barrier3")
        locationsArray.append(Barrier3)
        
        let Boscombe = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.719517, longitude: -1.843064), regionDistance: 50, identifier: "Boscombe")
        locationsArray.append(Boscombe)
        
        //Final Location same as "Seafront"
        
        let Final = MyLocation(coord: CLLocationCoordinate2D(latitude: 50.715591, longitude: -1.875529), regionDistance: 50, identifier: "Final")
        locationsArray.append(Final)
        
        
    //Locations Array will constantly monitor for region.
        for location in locationsArray {
            locationManager.startMonitoringForRegion(location.region)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Locations array is passed into Log View Controller.
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
            //Locations array stores distance from set coordinates.
            for location in locationsArray {
                location.distance = newLocation.distanceFromLocation(CLLocation(latitude: location.coord.latitude, longitude: location.coord.longitude)) 
            }
            
          
            //Loactions array sorted so the closest region is first in array.
            locationsArray.sortInPlace { return $0.distance < $1.distance }
            
            //Prints name of closest array.
            print(locationsArray.first!.identifier)
            //print(locationsArray.first!.distance)
            
            
            // Switch statement turns distance from closest region into an alpha value for the GIF. 
            //Allowing GIF opcaity to increase as user gets nearer to geocache.
            switch locationsArray.first!.distance {
            case 0..<49:
                imageView.alpha = 0.8
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.85
                }
                audioPlayer.volume = 0.95

            case 50..<59:
                imageView.alpha = 0.75
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.8
                }
                audioPlayer.volume = 0.9

            case 60..<69:
                imageView.alpha = 0.7
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.75
                }
                audioPlayer.volume = 0.85

            case 70..<79:
                imageView.alpha = 0.65
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.7
                }
                audioPlayer.volume = 0.8

            case 80..<89:
                imageView.alpha = 0.6
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.65
                }
                audioPlayer.volume = 0.75

            case 90..<99:
                imageView.alpha = 0.55
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.6
                }
                audioPlayer.volume = 0.7

            case 100..<109:
                imageView.alpha = 0.5
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.55
                }
                audioPlayer.volume = 0.65

            case 110..<119:
                imageView.alpha = 0.45
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.5
                }
                audioPlayer.volume = 0.6

            case 120..<129:
                imageView.alpha = 0.4
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.45
                }
                audioPlayer.volume = 0.45

            case 130..<139:
                imageView.alpha = 35
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.4
                }
                audioPlayer.volume = 0.4

            case 140..<149:
                imageView.alpha = 0.3
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.35
                }
                audioPlayer.volume = 0.35

            case 150..<159:
                imageView.alpha = 0.25
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.3
                }
                audioPlayer.volume = 0.3

            case 160..<169:
                imageView.alpha = 0.2
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.25
                }
                audioPlayer.volume = 0.25

            case 170..<179:
                imageView.alpha = 0.15
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.2
                }
                audioPlayer.volume = 0.2

            case 180..<189:
                imageView.alpha = 0.1
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.15
                }
                audioPlayer.volume = 0.15

            case 190..<200:
                imageView.alpha = 0
                UIView.animateWithDuration(1.0) {
                    self.imageView.alpha = 0.1
                }
                audioPlayer.volume = 0.1
                
            //GIF invisible + Audio off by default.
            default:
                imageView.alpha = 0
                audioPlayer.volume = 0
            }
            
        }
        
    }
    
    
  
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        //Adds identifier to Visited array (Won't add location again if region has already been visited).
        if !visitedArray.contains(region.identifier) {
            visitedArray.append(region.identifier)
        }
        
        for location in locationsArray {
            if location.regionDistance > 51 {
                location.isFound = false
            }
        }
        
        

        //first geocache opens with 2sec fade in animation.
        if  region.identifier == "Seafront" {
            
            Fragment1Img.alpha = 0
            UIView.animateWithDuration(2.0) {
                self.Fragment1Img.alpha = 1
                
            }
            
            //if the user is in a region, check it off in the log.
            for location in locationsArray {
                if region.identifier == location.identifier {
                    location.isFound = true
                }
            }
            
            //phone vibrates when geocache is found.
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            
            
        }
        
        //Can only see geocache if user has been to Seafront region first
        if  region.identifier == "Oceanarium" && visitedArray.contains("Seafront")  {
            
            Fragment2Img.alpha = 0
            UIView.animateWithDuration(2.0) {
                self.Fragment2Img.alpha = 1
                
            }
            
            //if the user is in a region, check it off in the log.
            for location in locationsArray {
                if region.identifier == location.identifier {
                    location.isFound = true
                }
            }
            
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            
            
        }
        
        //Can only see Boscombe image if user has been to Oceanarium
        
        if  region.identifier == "Boscombe" && visitedArray.contains("Oceanarium")  {
            
            Fragment3Img.alpha = 0
            UIView.animateWithDuration(2.0) {
                self.Fragment3Img.alpha = 1
                
            }
            
            //if the user is in a region, check it off in the log.
            for location in locationsArray {
                if region.identifier == location.identifier {
                    location.isFound = true
                }
            }
            
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            
            
        }
        
        //Can only See final image if user has been to Boscombe.
        
        if  region.identifier == "Final" && visitedArray.contains("Boscombe")  {
            
            Fragment1Img.removeFromSuperview()
            
            Fragment4Img.alpha = 0
            UIView.animateWithDuration(2.0) {
                self.Fragment4Img.alpha = 1
                
            }
            
            //As it is the same location as seafront, we turn off the Seafront image so it does not conflict with 'Final' image.
            
            
            //if the user is in a region, check it off in the log.
            for location in locationsArray {
                if region.identifier == location.identifier {
                    location.isFound = true
                }
            }
            
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            
            
        }
        

        
        
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        //all images 'Turn-off' when region is left.
        
        Fragment1Img.alpha = 0
        Fragment2Img.alpha = 0
        Fragment3Img.alpha = 0
        Fragment4Img.alpha = 0
        imageView.alpha = 0
        
    }
    
    
}