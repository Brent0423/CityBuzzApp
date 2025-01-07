import SwiftUI
import MapKit

struct Event: Identifiable {
    let id = UUID()
    let name: String
    let date: String
    let location: Location
    let category: String
}

struct Location {
    let name: String
    let area: String
    let city: String
    let fullAddress: String
    let coordinate: CLLocationCoordinate2D
    
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
} 