import Foundation
import SwiftUI

class EventStore: ObservableObject {
    @Published private(set) var events: [Event] = []
    
    init() {
        loadEvents()
        
        // Add sample events if none exist
        if events.isEmpty {
            let sampleEvents = [
                Event(
                    title: "Bell's Winter Beer Garden",
                    description: "Join us for winter brews and fun!",
                    date: Date().addingTimeInterval(86400), // Tomorrow
                    location: "Bell's Eccentric Cafe, Downtown",
                    category: "Food & Drinks"
                ),
                Event(
                    title: "Winter Art Hop",
                    description: "Explore local art galleries",
                    date: Date().addingTimeInterval(86400 * 2), // Day after tomorrow
                    location: "Kalamazoo Mall, Downtown",
                    category: "Arts & Culture"
                )
            ]
            
            events = sampleEvents
            saveEvents()
        }
    }
    
    func addEvent(_ event: Event) {
        events.append(event)
        saveEvents()
    }
    
    func deleteEvent(_ event: Event) {
        events.removeAll { $0.id == event.id }
        saveEvents()
    }
    
    func updateEvent(_ event: Event) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index] = event
            saveEvents()
        }
    }
    
    private func saveEvents() {
        do {
            let data = try JSONEncoder().encode(events)
            UserDefaults.standard.set(data, forKey: "savedEvents")
        } catch {
            print("Failed to save events: \(error)")
        }
    }
    
    private func loadEvents() {
        guard let data = UserDefaults.standard.data(forKey: "savedEvents") else { return }
        
        do {
            events = try JSONDecoder().decode([Event].self, from: data)
        } catch {
            print("Failed to load events: \(error)")
        }
    }
} 