import SwiftUI

enum EventError: Error {
    case loadingFailed
    case networkError
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .loadingFailed:
            return "Failed to load events"
        case .networkError:
            return "Network connection error"
        case .invalidData:
            return "Invalid data received"
        }
    }
}

class EventService {
    static func loadEvents(page: Int) async throws -> [Event] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        return [
            Event(name: "K-Wings Hockey", 
                  date: "1/22 @ 7 PM", 
                  location: Location(
                      name: "Wings Event Center",
                      area: "Portage",
                      city: "Kalamazoo",
                      fullAddress: "3600 Vanrick Dr, Kalamazoo, MI 49001"
                  ),
                  image: "hockey.stick", 
                  category: "Sports"),
            
            Event(name: "Farmers Market", 
                  date: "1/23 @ 8 AM", 
                  location: Location(
                      name: "Bank Street Market",
                      area: "Edison",
                      city: "Kalamazoo",
                      fullAddress: "1157 Bank St, Kalamazoo, MI 49001"
                  ),
                  image: "leaf.fill", 
                  category: "Markets"),
            
            Event(name: "WMU Basketball", 
                  date: "1/24 @ 7 PM", 
                  location: Location(
                      name: "University Arena",
                      area: "WMU Campus",
                      city: "Kalamazoo",
                      fullAddress: "Read Fieldhouse, Kalamazoo, MI 49008"
                  ),
                  image: "basketball.fill", 
                  category: "College Events"),
            
            Event(name: "KIA Exhibition", 
                  date: "1/25 @ 11 AM", 
                  location: Location(
                      name: "Kalamazoo Institute of Arts",
                      area: "Downtown",
                      city: "Kalamazoo",
                      fullAddress: "314 S Park St, Kalamazoo, MI 49007"
                  ),
                  image: "photo.fill", 
                  category: "Arts & Culture")
        ]
    }
} 
