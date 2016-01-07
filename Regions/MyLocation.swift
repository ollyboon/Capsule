import Foundation
import CoreLocation

class MyLocation {
    
    var coord: CLLocationCoordinate2D!
    var distance: Double!
    var regionDistance: Double!
    var identifier: String!
    var isFound = false
    
    var region: CLCircularRegion  {
        return CLCircularRegion(center: coord, radius: regionDistance, identifier: identifier)
    }
    
    init(coord: CLLocationCoordinate2D, regionDistance: Double, identifier: String) {
        self.coord = coord
        self.regionDistance = regionDistance
        self.identifier = identifier
    }
    
}
