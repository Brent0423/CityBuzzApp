import SwiftUI

struct HomeScreen: View {
    @State private var searchText = ""
    @State private var selectedDate = Date().addingTimeInterval(-365*24*60*60)
    @State private var showDatePicker = false
    @Namespace private var animation
    
    let gradients = [
        [Color(hex: "FF6B6B"), Color(hex: "4ECDC4")],
        [Color(hex: "A8E6CF"), Color(hex: "3B4371")],
        [Color(hex: "FFD93D"), Color(hex: "FF6B6B")]
    ]
    
    let events = [
        Event(name: "Bell's Winter Beer Garden", date: "1/16 @ 7 PM", location: Location(name: "Bell's Eccentric Cafe", area: "Downtown", city: "Kalamazoo", fullAddress: "355 E Kalamazoo Ave, Kalamazoo, MI 49007"), image: "mug.fill", category: "Food & Drinks"),
        Event(name: "Winter Art Hop", date: "1/18 @ 5 PM", location: Location(name: "Kalamazoo Mall", area: "Downtown", city: "Kalamazoo", fullAddress: "100 W Michigan Ave, Kalamazoo, MI 49007"), image: "paintpalette.fill", category: "Arts & Culture"),
        Event(name: "State Theatre Concert", date: "1/20 @ 8 PM", location: Location(name: "Kalamazoo State Theatre", area: "Downtown", city: "Kalamazoo", fullAddress: "404 S Burdick St, Kalamazoo, MI 49007"), image: "music.note", category: "Music & Concerts"),
        Event(name: "Comedy Night", date: "1/21 @ 9 PM", location: Location(name: "Shakespeare's Pub", area: "Downtown", city: "Kalamazoo", fullAddress: "241 E Kalamazoo Ave, Kalamazoo, MI 49007"), image: "theatermasks.fill", category: "Nightlife")
    ]
    
    var filteredEvents: [Event] {
        var filtered = events
        
        if !searchText.isEmpty {
            filtered = filtered.filter { event in
                event.name.localizedCaseInsensitiveContains(searchText) || 
                event.location.name.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        if selectedDate > Date().addingTimeInterval(-364*24*60*60) {
            let calendar = Calendar.current
            filtered = filtered.filter { event in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "M/dd '@' h a"
                guard let eventDate = dateFormatter.date(from: event.date) else { return false }
                return calendar.isDate(eventDate, inSameDayAs: selectedDate)
            }
        }
        
        return filtered
    }
    
    var featuredEvents: [Event] {
        Array(events.prefix(3))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search events...", text: $searchText)
                            .foregroundColor(.primary)
                    }
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // Date Filter
                    HStack(spacing: 12) {
                        DateSelectionButton(title: "All", isSelected: selectedDate < Date().addingTimeInterval(-364*24*60*60)) {
                            selectedDate = Date().addingTimeInterval(-365*24*60*60)
                        }
                        
                        DateSelectionButton(title: "Today", isSelected: Calendar.current.isDateInToday(selectedDate)) {
                            selectedDate = Date()
                        }
                        
                        DateSelectionButton(title: "Tomorrow", isSelected: Calendar.current.isDateInTomorrow(selectedDate)) {
                            selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
                        }
                        
                        Button(action: { showDatePicker.toggle() }) {
                            Image(systemName: "calendar")
                                .foregroundColor(.primary)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    
                    if showDatePicker {
                        DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                    
                    // Featured Section
                    VStack(alignment: .leading) {
                        Text("Featured")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(featuredEvents) { event in
                                    FeaturedEventCard(event: event, gradient: gradients[events.firstIndex(of: event)! % gradients.count])
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Event List
                    LazyVStack(spacing: 12) {
                        ForEach(filteredEvents) { event in
                            EventListItem(event: event)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("City Buzz")
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.dark)
    }
}

struct FeaturedEventCard: View {
    let event: Event
    let gradient: [Color]
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(height: 160)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text(event.date)
                        
                        Image(systemName: "mappin")
                        Text(event.location.name)
                    }
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.9))
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(LinearGradient(colors: [.black.opacity(0.7), .clear], startPoint: .bottom, endPoint: .top))
            }
        }
        .frame(width: 280)
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}

struct DateSelectionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .cornerRadius(10)
        }
    }
}

struct EventListItem: View {
    let event: Event
    
    func getIconColor(for category: String) -> Color {
        switch category {
        case "Food & Drinks":
            return Color(hex: "FF7B7B") // Red
        case "Arts & Culture":
            return Color(hex: "5151C6") // Purple
        case "Music & Concerts":
            return Color(hex: "8CD5C9") // Teal
        case "Nightlife":
            return Color(hex: "FFD426") // Yellow
        default:
            return .blue
        }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: event.image)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(getIconColor(for: event.category))
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.name)
                    .font(.headline)
                
                HStack {
                    Text(event.date)
                    Text("•")
                    Text(event.location.name)
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
