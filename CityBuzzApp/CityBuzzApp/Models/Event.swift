import SwiftUI
import MapKit

struct Event: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let date: String
    let location: Location
    let image: String
    let category: String
    
    var categoryColor: Color {
        switch category {
        case "Sports":
            return Color.blue
        case "Food & Drinks":
            return Color(hex: "FF7B7B")
        case "Arts & Culture":
            return Color(hex: "5151C6")
        case "Music & Concerts":
            return Color(hex: "8CD5C9")
        case "Nightlife":
            return Color(hex: "FFD426")
        default:
            return .blue
        }
    }
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }
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