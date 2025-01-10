import SwiftUI

struct HomeScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var eventManager = EventManager.shared
    @State private var searchText = ""
    @State private var selectedDate = Date().addingTimeInterval(-365*24*60*60)
    @State private var showDatePicker = false
    @Binding var homeStack: NavigationPath
    @Namespace private var animation
    
    let gradients = [
        [Color(hex: "FF6B6B"), Color(hex: "4ECDC4")],
        [Color(hex: "A8E6CF"), Color(hex: "3B4371")],
        [Color(hex: "FFD93D"), Color(hex: "FF6B6B")]
    ]
    
    let events = [
        Event(name: "Bell's Winter Beer Garden", 
              date: "1/16 @ 7 PM", 
              location: Location(
                  name: "Bell's Eccentric Cafe", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "355 E Kalamazoo Ave, Kalamazoo, MI 49007",
                  latitude: 42.2917,
                  longitude: -85.5872
              ),
              category: "Food & Drinks",
              description: "Enjoy craft beers and seasonal treats in Bell's cozy outdoor winter garden."),
        Event(name: "Winter Art Hop", 
              date: "1/18 @ 5 PM", 
              location: Location(
                  name: "Kalamazoo Mall", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "100 W Michigan Ave, Kalamazoo, MI 49007",
                  latitude: 42.2912,
                  longitude: -85.5850
              ),
              category: "Arts & Culture",
              description: "Explore local art galleries and shops during this monthly downtown art walk."),
        Event(name: "State Theatre Concert", 
              date: "1/20 @ 8 PM", 
              location: Location(
                  name: "Kalamazoo State Theatre", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "404 S Burdick St, Kalamazoo, MI 49007",
                  latitude: 42.2906,
                  longitude: -85.5859
              ),
              category: "Music & Concerts",
              description: "Live music performance at the historic Kalamazoo State Theatre."),
        Event(name: "Comedy Night", 
              date: "1/21 @ 9 PM", 
              location: Location(
                  name: "Shakespeare's Pub", 
                  area: "Downtown", 
                  city: "Kalamazoo", 
                  fullAddress: "241 E Kalamazoo Ave, Kalamazoo, MI 49007",
                  latitude: 42.2918,
                  longitude: -85.5833
              ),
              category: "Nightlife",
              description: "Stand-up comedy showcase featuring local and touring comedians.")
    ]
    
    var filteredEvents: [Event] {
        let events = eventManager.getAllEvents()
        print("🔴 DEBUG: HomeScreen filtered events count: \(events.count)")
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd '@' h a"
        
        // First filter out past events
        let currentEvents = events.filter { event in
            guard let eventDate = dateFormatter.date(from: event.date) else { 
                print("⚠️ Failed to parse date for event: \(event.name)")
                return false 
            }
            
            let currentYear = calendar.component(.year, from: Date())
            var components = calendar.dateComponents([.month, .day, .hour], from: eventDate)
            components.year = currentYear
            
            guard let fullEventDate = calendar.date(from: components) else { 
                print("⚠️ Failed to create full date for event: \(event.name)")
                return false 
            }
            
            // For today's events, include them if they're today regardless of time
            if calendar.isDateInToday(fullEventDate) {
                print("📅 Today's Event: \(event.name)")
                return true
            }
            
            let isCurrentEvent = fullEventDate >= Date()
            print("📅 Event: \(event.name)")
            print("   Date: \(fullEventDate)")
            print("   Is Current: \(isCurrentEvent)")
            return isCurrentEvent
        }
        
        // Print filtered results
        print("\n🔍 Found \(currentEvents.count) current events")
        currentEvents.forEach { event in
            print("- \(event.name) (\(event.date))")
        }
        
        // Then apply search filter
        if !searchText.isEmpty {
            return currentEvents.filter { event in
                event.name.localizedCaseInsensitiveContains(searchText) || 
                event.location.name.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Then apply date filter
        if selectedDate > Date().addingTimeInterval(-364*24*60*60) {
            return currentEvents.filter { event in
                guard let eventDate = dateFormatter.date(from: event.date) else { return false }
                let eventDay = calendar.dateComponents([.month, .day], from: eventDate)
                let selectedDay = calendar.dateComponents([.month, .day], from: selectedDate)
                return eventDay.month == selectedDay.month && eventDay.day == selectedDay.day
            }
        }
        
        return currentEvents
    }
    
    var featuredEvents: [Event] {
        Array(events.prefix(3))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Text("City Buzz")
                        .font(.system(size: 42, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 4)
                        .foregroundColor(.white)
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search events...", text: $searchText)
                            .foregroundColor(.white)
                            .autocapitalization(.none)
                            .submitLabel(.search)
                        
                        if !searchText.isEmpty {
                            Button(action: { 
                                withAnimation { searchText = "" }
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(10)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal, 20)
                    
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
                                .font(.system(size: 18))
                                .foregroundColor(.primary)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    if showDatePicker {
                        DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding(.horizontal)
                            .onChange(of: selectedDate) { _ in
                                showDatePicker = false
                            }
                    }
                    
                    // Featured Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Featured")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                            .padding(.horizontal, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(Array(featuredEvents.enumerated()), id: \.element.id) { index, event in
                                    NavigationLink(value: event.id.uuidString) {
                                        FeaturedEventCard(event: event, gradient: gradients[index % gradients.count])
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    // Event List
                    LazyVStack(spacing: 10) {
                        ForEach(filteredEvents) { event in
                            NavigationLink(value: event.id.uuidString) {
                                EventListItem(event: event, homeStack: $homeStack)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.vertical, 8)
            }
            .navigationBarHidden(true)
        }
        .preferredColorScheme(.dark)
        .gesture(
            DragGesture()
                .onEnded { gesture in
                    if gesture.translation.width > 100 {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
        )
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
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(event.name)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 12) {
                        HStack(spacing: 6) {
                            Image(systemName: "calendar")
                                .font(.system(size: 16))
                            Text(event.date)
                                .font(.system(size: 16))
                        }
                        
                        HStack(spacing: 6) {
                            Image(systemName: "mappin")
                                .font(.system(size: 16))
                            Text(event.location.name)
                                .font(.system(size: 16))
                                .lineLimit(1)
                        }
                    }
                    .foregroundColor(.white.opacity(0.9))
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(LinearGradient(colors: [.black.opacity(0.8), .clear], startPoint: .bottom, endPoint: .top))
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
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .cornerRadius(10)
        }
    }
}

#Preview {
    HomeScreen(homeStack: .constant(NavigationPath()))
}
