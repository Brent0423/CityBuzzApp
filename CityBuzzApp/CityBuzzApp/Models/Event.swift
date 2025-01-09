import SwiftUI
import MapKit

struct Event: Identifiable, Hashable {
    let id: UUID
    let name: String
    let date: String
    let location: Location
    let category: String
    let description: String?
    
    init(name: String, date: String, location: Location, category: String, description: String? = nil) {
        self.id = UUID()
        self.name = name
        self.date = date
        self.location = location
        self.category = category
        self.description = description
    }
    
    // Add Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }
}