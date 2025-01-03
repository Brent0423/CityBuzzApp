import SwiftUI

enum EventError: Error {
    case loadingFailed
    case networkError
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .loadingFailed:
            return "Failed to load events. Please try again."
        case .networkError:
            return "Network connection error. Please check your connection."
        case .invalidData:
            return "Invalid data received. Please try again."
        }
    }
}

class EventService {
    static func loadEvents(page: Int) async throws -> [Event] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Simulate loading more events
        return [
            Event(name: "New Food Festival", date: "2/1 @ 2 PM", location: "City Center", image: "fork.knife", category: "Food & Drinks"),
            Event(name: "Rock Concert", date: "2/2 @ 8 PM", location: "Stadium", image: "music.note", category: "Music & Concerts"),
            Event(name: "Art Show", date: "2/3 @ 5 PM", location: "Art Gallery", image: "paintpalette.fill", category: "Arts & Culture"),
            Event(name: "Stand-up Night", date: "2/4 @ 9 PM", location: "Comedy Club", image: "theatermasks.fill", category: "Comedy")
        ]
    }
} 