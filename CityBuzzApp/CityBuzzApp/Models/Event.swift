import Foundation

struct Event: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let date: String
    let location: Location
    let image: String
    let category: String
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }
}

struct Location {
    let name: String
    let area: String
    let city: String
    let fullAddress: String
    
    var shortDisplay: String {
        return name
    }
    
    var mediumDisplay: String {
        return "\(name), \(area)"
    }
} 