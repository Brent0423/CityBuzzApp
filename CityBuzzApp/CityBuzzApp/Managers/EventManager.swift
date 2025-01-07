import Foundation

class EventManager {
    static let shared = EventManager()
    
    private var events: [Event] = [
        Event(name: "K-Wings Hockey", 
              date: "1/22 @ 7 PM", 
              location: Location(
                  name: "Wings Event Center", 
                  area: "Kalamazoo", 
                  city: "Kalamazoo", 
                  fullAddress: "3600 Vanrick Dr, Kalamazoo, MI 49001",
                  latitude: 42.2547,
                  longitude: -85.5494
              ), 
              image: "hockey.stick", 
              category: "Sports"),
        
        Event(name: "Farmers Market", 
              date: "1/23 @ 9 AM", 
              location: Location(
                  name: "Bank Street Market", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "1157 Bank St, Kalamazoo, MI 49001",
                  latitude: 42.2896,
                  longitude: -85.5851
              ), 
              image: "leaf.fill", 
              category: "Markets"),
          
        Event(name: "WMU Basketball", 
              date: "1/24 @ 7 PM", 
              location: Location(
                  name: "University Arena", 
                  area: "WMU", 
                  city: "Kalamazoo", 
                  fullAddress: "Read Fieldhouse, Kalamazoo, MI 49008",
                  latitude: 42.2850,
                  longitude: -85.6147
              ), 
              image: "basketball.fill", 
              category: "Sports"),
          
        Event(name: "KIA Exhibition", 
              date: "1/25 @ 11 AM", 
              location: Location(
                  name: "Kalamazoo Institute of Arts", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "314 S Park St, Kalamazoo, MI 49007",
                  latitude: 42.2906,
                  longitude: -85.5859
              ), 
              image: "photo.fill", 
              category: "Arts & Culture")
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