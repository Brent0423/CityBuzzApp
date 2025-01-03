import SwiftUI

struct Event: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let date: String
    let location: String
    let image: String
    let category: String
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }
}

struct HomeScreen: View {
    // Sample Data
    let categories = [
        "Food & Drinks",     // Most popular city activity
        "Music & Concerts",  // Major draw for city events
        "Nightlife",        // Key city entertainment
        "Community",        // Local engagement
        "Arts & Culture",   // Cultural activities
        "Markets",         // Local commerce and gatherings
        "Sports & Fitness", // Active events
        "Comedy",          // Entertainment events
        "Theater",         // Cultural performances
        "Family Fun",      // Inclusive activities
        "Workshops",       // Educational/skill-building
        "Charity"          // Community service
    ]
    let events = [
        Event(name: "Bells Event", date: "1/16 @ 7 PM", location: "Bell Tower", image: "ticket.fill", category: "Theater"),
        Event(name: "Charity Walk", date: "1/18 @ 3 PM", location: "Central Park", image: "figure.walk", category: "Charity"),
        Event(name: "Food Festival", date: "1/20 @ 12 PM", location: "Downtown Square", image: "fork.knife", category: "Food & Drinks"),
        Event(name: "Club Night", date: "1/21 @ 9 PM", location: "Student Center", image: "music.note", category: "Nightlife")
    ]
    
    @State private var searchText = ""
    
    // Filtered events based on search text
    private var filteredEvents: [Event] {
        if searchText.isEmpty {
            return events
        } else {
            return events.filter { event in
                event.name.localizedCaseInsensitiveContains(searchText) ||
                event.location.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search events...", text: $searchText)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                        .submitLabel(.search)
                }
                .padding(12)
                .background(Color.white.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 10)
                
                // Categories
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(categories, id: \.self) { category in
                            VStack {
                                Text(category)
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 12)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .cornerRadius(25)
                                    .shadow(color: .white.opacity(0.1), radius: 5, x: 0, y: 2)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                }
                .padding(.bottom, 10)
                
                // Events List
                if filteredEvents.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("No events found")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .medium))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(filteredEvents) { event in
                                EventCard(event: event)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("City Buzz")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .background(Color.black)
            .preferredColorScheme(.dark)
        }
    }
}

struct EventCard: View {
    let event: Event
    
    var body: some View {
        HStack(spacing: 16) {
            // Left side - Icon
            Circle()
                .fill(.blue)
                .frame(width: 44, height: 44)
                .overlay(
                    Image(systemName: event.image)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                )
            
            // Event Details
            VStack(alignment: .leading, spacing: 4) {
                // Event Name
                Text(event.name)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                
                // Date and Location
                HStack(spacing: 4) {
                    // Calendar icon and date
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text(event.date)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                    
                    // Location
                    HStack(spacing: 4) {
                        Image(systemName: "mappin")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        Text(event.location)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            // Chevron
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.black)
        .cornerRadius(12)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
} 