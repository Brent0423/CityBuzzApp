import SwiftUI
import FirebaseFirestore

class EventManager: ObservableObject {
    static let shared = EventManager()
    @Published private(set) var events: [Event] = []
    private let db = Firestore.firestore()
    
    private init() {
        fetchEvents()
    }
    
    func submitEvent(_ event: Event) {
        print("Attempting to save event: \(event.name)")
        do {
            try db.collection("events").addDocument(from: event)
            events.insert(event, at: 0)
            objectWillChange.send()
            print("✅ Successfully saved event to Firestore")
        } catch {
            print("❌ Error saving event: \(error.localizedDescription)")
        }
    }
    
    func fetchEvents() {
        print("Attempting to fetch events from Firestore...")
        db.collection("events")
            .order(by: "date", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("❌ Firestore Error: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No documents found in Firestore")
                    return
                }
                
                print("📝 Found \(documents.count) events in Firestore")
                self?.events = documents.compactMap { document in
                    try? document.data(as: Event.self)
                }
                print("✅ Successfully loaded \(self?.events.count ?? 0) events")
            }
    }
    
    func getEvent(id: UUID) -> Event? {
        return events.first { $0.id == id }
    }
} 