import Foundation

class EventManager {
    static let shared = EventManager()
    
    private var events: [Event] = [
        // Early January
        Event(name: "Kalamazoo Wings vs Fort Wayne", 
              date: "1/7 @ 7 PM", 
              location: Location(
                  name: "Wings Event Center", 
                  area: "Kalamazoo", 
                  city: "Kalamazoo", 
                  fullAddress: "3600 Vanrick Dr, Kalamazoo, MI 49001",
                  latitude: 42.2547,
                  longitude: -85.5494
              ),
              category: "Sports"),
              
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

        // Today
        Event(name: "K-Wings vs Toledo Walleye", 
              date: "2/13 @ 7 PM", 
              location: Location(
                  name: "Wings Event Center", 
                  area: "Kalamazoo", 
                  city: "Kalamazoo", 
                  fullAddress: "3600 Vanrick Dr, Kalamazoo, MI 49001",
                  latitude: 42.2547,
                  longitude: -85.5494
              ),
              category: "Sports"),
              
        Event(name: "Open Mic Comedy Night", 
              date: "2/13 @ 8 PM", 
              location: Location(
                  name: "Shakespeare's Pub", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "241 E Kalamazoo Ave, Kalamazoo, MI 49007",
                  latitude: 42.2918,
                  longitude: -85.5833
              ),
              category: "Comedy"),

        // Tomorrow
        Event(name: "Winter Art Hop", 
              date: "2/14 @ 5 PM", 
              location: Location(
                  name: "Kalamazoo Mall", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "100 W Michigan Ave, Kalamazoo, MI 49007",
                  latitude: 42.2912,
                  longitude: -85.5850
              ),
              category: "Arts & Culture"),
              
        Event(name: "Valentine's Day Jazz Night", 
              date: "2/14 @ 7 PM", 
              location: Location(
                  name: "Bell's Eccentric Cafe", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "355 E Kalamazoo Ave, Kalamazoo, MI 49007",
                  latitude: 42.2917,
                  longitude: -85.5872
              ),
              category: "Music & Concerts"),

        // This Weekend
        Event(name: "Winter Farmers Market", 
              date: "2/17 @ 8 AM", 
              location: Location(
                  name: "Bank Street Market", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "1157 Bank St, Kalamazoo, MI 49001",
                  latitude: 42.2896,
                  longitude: -85.5851
              ),
              category: "Markets"),
              
        Event(name: "Late Night at The Union", 
              date: "2/17 @ 10 PM", 
              location: Location(
                  name: "The Union", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "125 S Kalamazoo Mall, Kalamazoo, MI 49007",
                  latitude: 42.2914,
                  longitude: -85.5850
              ),
              category: "Nightlife"),

        // Next Week
        Event(name: "Community Food Drive", 
              date: "2/20 @ 11 AM", 
              location: Location(
                  name: "Bronson Park", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "200 S Rose St, Kalamazoo, MI 49007",
                  latitude: 42.2916,
                  longitude: -85.5859
              ),
              category: "Charity"),
              
        Event(name: "Family Game Day", 
              date: "2/20 @ 2 PM", 
              location: Location(
                  name: "Kalamazoo Public Library", 
                  area: "Central", 
                  city: "Kalamazoo", 
                  fullAddress: "315 S Rose St, Kalamazoo, MI 49007",
                  latitude: 42.2908,
                  longitude: -85.5859
              ),
              category: "Family Fun"),

        Event(name: "DIY Workshop: Home Brewing", 
              date: "2/21 @ 6 PM", 
              location: Location(
                  name: "Bell's Eccentric Cafe", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "355 E Kalamazoo Ave, Kalamazoo, MI 49007",
                  latitude: 42.2917,
                  longitude: -85.5872
              ),
              category: "Workshops"),

        Event(name: "Anastasia - The Musical", 
              date: "2/22 @ 7:30 PM", 
              location: Location(
                  name: "Miller Auditorium", 
                  area: "WMU Campus", 
                  city: "Kalamazoo", 
                  fullAddress: "2200 Auditorium Dr, Kalamazoo, MI 49008",
                  latitude: 42.2828,
                  longitude: -85.6147
              ),
              category: "Theater"),

        Event(name: "Food Truck Rally", 
              date: "2/23 @ 11 AM", 
              location: Location(
                  name: "Bronson Park", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "200 S Rose St, Kalamazoo, MI 49007",
                  latitude: 42.2916,
                  longitude: -85.5859
              ),
              category: "Food & Drinks")
    ]
    
    func getAllEvents() -> [Event] {
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