import SwiftUI

struct HomeScreen: View {
    @State private var searchText = ""
    @State private var selectedCategory: String?
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
        
        if !searchText.isEmpty || selectedCategory != nil {
            filtered = filtered.filter { event in
                let matchesSearch = searchText.isEmpty || event.name.localizedCaseInsensitiveContains(searchText) || event.location.name.localizedCaseInsensitiveContains(searchText)
                let matchesCategory = selectedCategory == nil || event.category == selectedCategory
                return matchesSearch && matchesCategory
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
    
    var trendingEvents: [Event] {
        Array(events.prefix(3))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                        TextField("Search events...", text: $searchText)
                            .foregroundColor(.white)
                            .font(.custom("Avenir-Medium", size: 16, relativeTo: .body))
                            .accessibilityLabel("Search events")
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white.opacity(0.08))
                            .shadow(color: .white.opacity(0.1), radius: 5, x: 0, y: 2)
                    )
                    .padding(.horizontal, 20)
                    .transition(.move(edge: .top))
                    
                    HStack {
                        DateSelectionButton(title: "All", isSelected: selectedDate < Date().addingTimeInterval(-364*24*60*60)) {
                            selectedDate = Date().addingTimeInterval(-365*24*60*60)
                            showDatePicker = false
                        }
                        
                        DateSelectionButton(title: "Today", isSelected: Calendar.current.isDateInToday(selectedDate)) {
                            selectedDate = Date()
                            showDatePicker = false
                        }
                        
                        DateSelectionButton(title: "Tomorrow", isSelected: Calendar.current.isDateInTomorrow(selectedDate)) {
                            if let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date()) {
                                selectedDate = tomorrow
                            }
                            showDatePicker = false
                        }
                        
                        Button(action: { showDatePicker.toggle() }) {
                            HStack(spacing: 4) {
                                Image(systemName: "calendar")
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background((!Calendar.current.isDateInToday(selectedDate) && !Calendar.current.isDateInTomorrow(selectedDate)) ? Color.white.opacity(0.2) : Color.clear)
                            .cornerRadius(8)
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    
                    if showDatePicker {
                        DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding(.horizontal, 20)
                            .accentColor(.white)
                            .colorScheme(.dark)
                            .onChange(of: selectedDate) { _ in
                                showDatePicker = false
                            }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Featured")
                            .font(.custom("Avenir-Heavy", size: 24, relativeTo: .title))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 20) {
                                ForEach(trendingEvents) { event in
                                    FeaturedEventCard(event: event, gradient: gradients[events.firstIndex(of: event)! % gradients.count])
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    LazyVStack(spacing: 12) {
                        ForEach(filteredEvents) { event in
                            EventCard(event: event)
                                .padding(.horizontal, 20)
                        }
                    }
                }
                .padding(.vertical, 20)
                .background(Color.black)
                .refreshable {
                    // Implement pull-to-refresh action here
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationTitle("City Buzz")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("City Buzz")
                        .font(.system(size: 42, weight: .heavy))
                        .foregroundColor(.white)
                        .shadow(color: Color.white.opacity(0.2), radius: 2, x: 0, y: 1)
                        .tracking(0.4)
                        .padding(.top, 20)
                }
            }
        }
    }
}

struct FeaturedEventCard: View {
    let event: Event
    let gradient: [Color]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .fill(LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(height: 180)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(event.name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .accessibilityLabel(event.name)
                    
                    HStack(spacing: 12) {
                        HStack(spacing: 4) {
                            Image(systemName: "calendar")
                            Text(event.date)
                        }
                        
                        HStack(spacing: 4) {
                            Image(systemName: "mappin")
                            Text(event.location.name)
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                }
                .padding()
                .background(LinearGradient(colors: [.black.opacity(0.7), .clear], startPoint: .bottom, endPoint: .top))
            }

        }
        .frame(width: 280)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

struct DateSelectionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.white.opacity(0.2) : Color.clear)
                .cornerRadius(8)
        }
    }
}

