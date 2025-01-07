import SwiftUI

class EventService: ObservableObject {
    @Published var events: [Event] = [
        Event(name: "Bell's Winter Beer Garden", date: "1/16 @ 7 PM", location: Location(name: "Bell's Eccentric Cafe"), category: .food),
        Event(name: "Winter Art Hop", date: "1/18 @ 5 PM", location: Location(name: "Kalamazoo Mall"), category: .art),
        Event(name: "State Theatre Concert", date: "1/20 @ 8 PM", location: Location(name: "Kalamazoo State Theatre"), category: .music),
        Event(name: "Comedy Night", date: "1/21 @ 9 PM", location: Location(name: "Shakespeare's Pub"), category: .comedy)
    ]
    
    func loadEvents() async -> [Event] {
        return events
    }
    
    func addEvent(_ event: Event) {
        events.append(event)
        objectWillChange.send()
    }
} 