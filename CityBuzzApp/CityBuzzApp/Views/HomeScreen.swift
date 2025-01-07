import SwiftUI

struct HomeScreen: View {
    @Environment(\.presentationMode) var presentationMode
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
              image: "mug.fill", 
              category: "Food & Drinks"),
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
              image: "paintpalette.fill", 
              category: "Arts & Culture"),
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
              image: "music.note", 
              category: "Music & Concerts"),
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
              image: "theatermasks.fill", 
              category: "Nightlife")
    ]
    
    var filteredEvents: [Event] {
        let events = EventManager.shared.getAllEvents()
        
        if !searchText.isEmpty {
            return events.filter { event in
                event.name.localizedCaseInsensitiveContains(searchText) || 
                event.location.name.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        if selectedDate > Date().addingTimeInterval(-364*24*60*60) {
            let calendar = Calendar.current
            return events.filter { event in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "M/dd '@' h a"
                guard let eventDate = dateFormatter.date(from: event.date) else { return false }
                return calendar.isDate(eventDate, inSameDayAs: selectedDate)
            }
        }
        
        return events
    }
    
    var featuredEvents: [Event] {
        Array(events.prefix(3))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    Text("City Buzz")
                        .font(.system(size: 40, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, -8)
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .font(.system(size: 18))
                        TextField("Search events...", text: $searchText)
                            .foregroundColor(.primary)
                            .font(.system(size: 18))
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
                                .font(.system(size: 18))
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
                            .onChange(of: selectedDate) { _ in
                                showDatePicker = false
                            }
                    }
                    
                    // Featured Section
                    VStack(alignment: .leading) {
                        Text("Featured")
                            .font(.system(size: 28, weight: .bold))
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(featuredEvents) { event in
                                    NavigationLink(value: event.id.uuidString) {
                                        FeaturedEventCard(event: event, gradient: gradients[events.firstIndex(of: event)! % gradients.count])
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Event List
                    LazyVStack(spacing: 12) {
                        ForEach(filteredEvents) { event in
                            NavigationLink(value: event.id.uuidString) {
                                EventListItem(event: event)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
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
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.name)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    
                    HStack {
                        Image(systemName: "calendar")
                            .font(.system(size: 14))
                        Text(event.date)
                            .font(.system(size: 14))
                        
                        Image(systemName: "mappin")
                            .font(.system(size: 14))
                        Text(event.location.name)
                            .font(.system(size: 14))
                    }
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
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .cornerRadius(10)
        }
    }
}
