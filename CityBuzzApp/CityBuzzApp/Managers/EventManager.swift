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
              category: "Food & Drinks",
              description: "Join us for a delicious gathering of Kalamazoo's best food trucks featuring local cuisine and street food favorites."),

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
              category: "Music & Concerts",
              description: "Enjoy live jazz music while savoring a delicious Sunday brunch at the historic Old Dog Tavern."),

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
              category: "Nightlife",
              description: "Experience Kalamazoo's vibrant nightlife scene with great music, drinks, and dancing at The Union."),

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
              category: "Community",
              description: "Help support local families in need by participating in our community food drive. All donations welcome."),

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
              category: "Arts & Culture",
              description: "Explore downtown galleries and venues featuring local artists, live music, and refreshments."),

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
              category: "Markets",
              description: "Shop local produce, artisanal goods, and handcrafted items at our indoor winter farmers market."),

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
              category: "Sports",
              description: "Cheer on the Kalamazoo Wings as they face off against the Toledo Walleye in this exciting hockey matchup."),

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
              category: "Comedy",
              description: "Laugh the night away with local comedians or try your hand at stand-up during our weekly open mic night."),

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
              category: "Theater",
              description: "Experience the Broadway sensation that transports us from the twilight of the Russian Empire to the euphoria of Paris in the 1920s."),

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
              category: "Family Fun",
              description: "Bring the whole family for an afternoon of board games, puzzles, and fun activities at the library."),

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
              category: "Workshops",
              description: "Learn the basics of home brewing from Bell's expert brewers in this hands-on workshop."),

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
              category: "Charity",
              description: "Support the Kalamazoo Humane Society at this fundraising event featuring live music, auctions, and refreshments.")
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