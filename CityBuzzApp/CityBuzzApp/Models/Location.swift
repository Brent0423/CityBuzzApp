import SwiftUI
import MapKit
import CoreLocation

struct Location: Hashable {
    let name: String
    let area: String
    let city: String
    let fullAddress: String
    let coordinate: CLLocationCoordinate2D
    
    // Computed properties for address display
    var streetAddress: String {
        let components = fullAddress.components(separatedBy: ",")
        return components[0].trimmingCharacters(in: .whitespaces)
    }
    
    var cityStateZip: String {
        let components = fullAddress.components(separatedBy: ",")
        if components.count > 1 {
            let lastPart = components[1].trimmingCharacters(in: .whitespaces)
            let parts = lastPart.components(separatedBy: " ")
            if parts.count >= 3 {
                // Format: "Kalamazoo, MI 49007"
                return lastPart
            }
            // If we don't have all components, return what we have
            return lastPart
        }
        return ""
    }
    
    var shortDisplay: String {
        return name
    }
    
    var mediumDisplay: String {
        return "\(name), \(area)"
    }
    
    init(name: String, area: String, city: String, fullAddress: String, latitude: Double = 0, longitude: Double = 0) {
        self.name = name
        self.area = area
        self.city = city
        self.fullAddress = fullAddress
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(area)
        hasher.combine(city)
        hasher.combine(fullAddress)
        hasher.combine(coordinate.latitude)
        hasher.combine(coordinate.longitude)
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.name == rhs.name &&
               lhs.area == rhs.area &&
               lhs.city == rhs.city &&
               lhs.fullAddress == rhs.fullAddress &&
               lhs.coordinate.latitude == rhs.coordinate.latitude &&
               lhs.coordinate.longitude == rhs.coordinate.longitude
    }
} 