import Foundation

class EventManager: ObservableObject {
    static let shared = EventManager()
    
    @Published private var events: [Event] = [
        // Food & Drinks
        Event(name: "Food Truck Rally", 
              date: "1/13 @ 11 AM", 
              location: Location(
                  name: "Bronson Park", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "200 S Rose St, Kalamazoo, MI 49007",
                  latitude: 42.2916,
                  longitude: -85.5859
              ),
              category: "Food & Drinks"),

        // Music & Concerts
        Event(name: "Sunday Jazz Brunch", 
              date: "1/8 @ 11 AM", 
              location: Location(
                  name: "Old Dog Tavern", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "402 E Kalamazoo Ave, Kalamazoo, MI 49007",
                  latitude: 42.2917,
                  longitude: -85.5833
              ),
              category: "Music & Concerts"),

        // Nightlife
        Event(name: "Late Night at The Union", 
              date: "1/12 @ 10 PM", 
              location: Location(
                  name: "The Union", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "125 S Kalamazoo Mall, Kalamazoo, MI 49007",
                  latitude: 42.2914,
                  longitude: -85.5850
              ),
              category: "Nightlife"),

        // Community
        Event(name: "Community Food Drive", 
              date: "1/15 @ 11 AM", 
              location: Location(
                  name: "Bronson Park", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "200 S Rose St, Kalamazoo, MI 49007",
                  latitude: 42.2916,
                  longitude: -85.5859
              ),
              category: "Community"),

        // Arts & Culture
        Event(name: "Winter Art Hop", 
              date: "1/14 @ 5 PM", 
              location: Location(
                  name: "Kalamazoo Mall", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "100 W Michigan Ave, Kalamazoo, MI 49007",
                  latitude: 42.2912,
                  longitude: -85.5850
              ),
              category: "Arts & Culture"),

        // Markets
        Event(name: "Winter Farmers Market", 
              date: "1/13 @ 8 AM", 
              location: Location(
                  name: "Bank Street Market", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "1157 Bank St, Kalamazoo, MI 49001",
                  latitude: 42.2896,
                  longitude: -85.5851
              ),
              category: "Markets"),

        // Sports
        Event(name: "K-Wings vs Toledo Walleye", 
              date: "1/11 @ 7 PM", 
              location: Location(
                  name: "Wings Event Center", 
                  area: "Kalamazoo", 
                  city: "Kalamazoo", 
                  fullAddress: "3600 Vanrick Dr, Kalamazoo, MI 49001",
                  latitude: 42.2547,
                  longitude: -85.5494
              ),
              category: "Sports"),

        // Comedy
        Event(name: "Open Mic Comedy Night", 
              date: "1/10 @ 8 PM", 
              location: Location(
                  name: "Shakespeare's Pub", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "241 E Kalamazoo Ave, Kalamazoo, MI 49007",
                  latitude: 42.2918,
                  longitude: -85.5833
              ),
              category: "Comedy"),

        // Theater
        Event(name: "Anastasia - The Musical", 
              date: "1/16 @ 7:30 PM", 
              location: Location(
                  name: "Miller Auditorium", 
                  area: "WMU Campus", 
                  city: "Kalamazoo", 
                  fullAddress: "2200 Auditorium Dr, Kalamazoo, MI 49008",
                  latitude: 42.2828,
                  longitude: -85.6147
              ),
              category: "Theater"),

        // Family Fun
        Event(name: "Family Game Day", 
              date: "1/14 @ 2 PM", 
              location: Location(
                  name: "Kalamazoo Public Library", 
                  area: "Central", 
                  city: "Kalamazoo", 
                  fullAddress: "315 S Rose St, Kalamazoo, MI 49007",
                  latitude: 42.2908,
                  longitude: -85.5859
              ),
              category: "Family Fun"),

        // Workshops
        Event(name: "DIY Workshop: Home Brewing", 
              date: "1/12 @ 6 PM", 
              location: Location(
                  name: "Bell's Eccentric Cafe", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "355 E Kalamazoo Ave, Kalamazoo, MI 49007",
                  latitude: 42.2917,
                  longitude: -85.5872
              ),
              category: "Workshops"),

        // Charity
        Event(name: "Kalamazoo Humane Society Fundraiser", 
              date: "1/15 @ 5 PM", 
              location: Location(
                  name: "Bell's Eccentric Cafe", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "355 E Kalamazoo Ave, Kalamazoo, MI 49007",
                  latitude: 42.2917,
                  longitude: -85.5872
              ),
              category: "Charity")
    ]
    
    func submitEvent(_ event: Event) {
        print("🔴 DEBUG: EventManager.submitEvent called")
        print("🔴 DEBUG: Current events count: \(events.count)")
        events.insert(event, at: 0)
        print("🔴 DEBUG: New events count: \(events.count)")
        print("🔴 DEBUG: First event is now: \(events[0].name)")
        objectWillChange.send()
    }
    
    func getAllEvents() -> [Event] {
        print("🔴 DEBUG: getAllEvents called, count: \(events.count)")
        return events
    }
    
    func getEvent(id: String) -> Event? {
        return events.first { $0.id.uuidString == id }
    }
    
    func addEvent(_ event: Event) {
        events.append(event)
    }
    
    private init() {} // Singleton
}