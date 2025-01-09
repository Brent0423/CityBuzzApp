import SwiftUI
// No need to explicitly import Event since it's part of the main target

// Event model will be shared from HomeScreen.swift

struct DiscoverScreen: View {
    @StateObject private var eventManager = EventManager.shared
    @State private var selectedCategories: Set<String> = []
    @State private var searchText = ""
    @State private var isLoading = false
    @State private var loadingError: Error?
    @State private var showError = false
    @State private var currentPage = 1
    @State private var hasMorePages = true
    @State private var events: [Event] = []
    @State private var showScrollToTop = false
    @State private var scrollOffset: CGFloat = 0
    @Binding var homeStack: NavigationPath
    @Namespace private var scrollSpace
    @Environment(\.dismiss) var dismiss
    
    // Cache selected categories
    @AppStorage("savedCategories") private var savedCategoriesData: Data = Data() {
        didSet {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: savedCategoriesData) {
                selectedCategories = decoded
            }
        }
    }
    
    // Sample categories with their respective icons
    let categoryItems = [
        CategoryItem(name: "Arts & Culture", 
                    icon: "paintpalette.fill", 
                    color: Color(hex: "FF4500")),  // Vibrant orange-red
        
        CategoryItem(name: "Charity", 
                    icon: "hand.raised.fill", 
                    color: Color(hex: "9370DB")),   // Medium purple
        
        CategoryItem(name: "Comedy", 
                    icon: "face.smiling.fill", 
                    color: Color(hex: "FFD700")),  // Golden yellow
        
        CategoryItem(name: "Community", 
                    icon: "person.3.fill", 
                    color: Color(hex: "20B2AA")),  // Light Sea Green
                    
        CategoryItem(name: "Family Fun", 
                    icon: "figure.2.and.child", 
                    color: Color(hex: "00CED1")),  // Turquoise
        
        CategoryItem(name: "Food & Drinks", 
                    icon: "fork.knife", 
                    color: Color(hex: "FF8C00")),  // Orange
        
        CategoryItem(name: "Markets", 
                    icon: "leaf.fill", 
                    color: Color(hex: "32CD32")),  // Lime green
        
        CategoryItem(name: "Music & Concerts", 
                    icon: "music.note.list", 
                    color: Color(hex: "8A2BE2")),  // Electric purple
        
        CategoryItem(name: "Nightlife", 
                    icon: "moon.stars.fill", 
                    color: Color(hex: "191970")),  // Midnight blue
        
        CategoryItem(name: "Sports", 
                    icon: "figure.run", 
                    color: Color(hex: "4169E1")),  // Royal Blue
        
        CategoryItem(name: "Theater", 
                    icon: "theatermasks.fill", 
                    color: Color(hex: "DC143C")),  // Crimson red
        
        CategoryItem(name: "Workshops", 
                    icon: "hammer.fill", 
                    color: Color(hex: "D2691E"))   // Chocolate brown
    ]
    
    var filteredEvents: [Event] {
        let events = eventManager.getAllEvents()
        if searchText.isEmpty && selectedCategories.isEmpty {
            return events
        }
        return events.filter { event in
            let matchesSearch = searchText.isEmpty || 
                event.name.localizedCaseInsensitiveContains(searchText) ||
                event.location.name.localizedCaseInsensitiveContains(searchText) ||
                event.location.area.localizedCaseInsensitiveContains(searchText)
            let matchesCategory = selectedCategories.isEmpty || selectedCategories.contains(event.category)
            return matchesSearch && matchesCategory
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        HStack {
                            Button(action: { dismiss() }) {
                                HStack(spacing: 4) {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 18))
                                    Text("Back")
                                        .font(.system(size: 17))
                                }
                                .foregroundColor(.white)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                let shareText = "Check out these events on CityBuzz!"
                                let av = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                   let window = windowScene.windows.first {
                                    window.rootViewController?.present(av, animated: true)
                                }
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(
                            Color.black
                                .ignoresSafeArea(edges: .top)
                        )
                        
                        // Title (moved down slightly)
                        Text("Discover")
                            .font(.system(size: 48, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 8)  // Added padding to account for header
                        
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
                        .padding(12)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                        .padding(.horizontal, 20)
                        
                        // Show either categories or search results
                        if searchText.isEmpty {
                            // Categories Grid
                            VStack(alignment: .leading, spacing: 15) {
                                HStack {
                                    Text("Categories")
                                        .font(.title2.bold())
                                        .foregroundColor(.white)
                                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                                        
                                    if !selectedCategories.isEmpty {
                                        Spacer()
                                        Button(action: {
                                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                                selectedCategories.removeAll()
                                            }
                                            let generator = UIImpactFeedbackGenerator(style: .medium)
                                            generator.impactOccurred()
                                        }) {
                                            HStack(spacing: 4) {
                                                Image(systemName: "xmark.circle.fill")
                                                Text("Clear")
                                            }
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14, weight: .medium))
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                                
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                                    ForEach(categoryItems, id: \.name) { category in
                                        CategoryCard(
                                            category: category,
                                            isSelected: selectedCategories.contains(category.name),
                                            action: {
                                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                                    toggleCategory(category.name)
                                                }
                                            }
                                        )
                                        .transition(.asymmetric(
                                            insertion: .scale.combined(with: .opacity),
                                            removal: .opacity
                                        ))
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                            
                            // Events List with title "Recommended for You"
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Recommended for You")
                                    .font(.title2.bold())
                                    .foregroundColor(.white)
                                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                                    .padding(.horizontal, 20)
                                
                                if filteredEvents.isEmpty {
                                    EmptyStateView()
                                } else {
                                    LazyVStack(spacing: 10) {
                                        ForEach(filteredEvents) { event in
                                            NavigationLink(value: event.id.uuidString) {
                                                EventListItem(event: event, homeStack: $homeStack)
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 20)
                                }
                            }
                        } else {
                            // Search Results
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Search Results")
                                    .font(.title2.bold())
                                    .foregroundColor(.white)
                                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                                    .padding(.horizontal, 20)
                                
                                if filteredEvents.isEmpty {
                                    EmptyStateView()
                                } else {
                                    LazyVStack(spacing: 10) {
                                        ForEach(filteredEvents) { event in
                                            NavigationLink(value: event.id.uuidString) {
                                                EventListItem(event: event, homeStack: $homeStack)
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 20)
                                }
                            }
                        }
                    }
                    .padding(.vertical)
                    .background(
                        GeometryReader { geometry in
                            Color.clear.preference(
                                key: ScrollOffsetPreferenceKey.self,
                                value: geometry.frame(in: .named("scroll")).minY
                            )
                        }
                    )
                }
                .coordinateSpace(name: "scroll")
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    scrollOffset = value
                    showScrollToTop = value < -150 // Show button after scrolling down 150pts
                }
                
                // Scroll to top button
                if showScrollToTop {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation(.spring()) {
                                    proxy.scrollTo(scrollSpace, anchor: .top)
                                }
                                let generator = UIImpactFeedbackGenerator(style: .light)
                                generator.impactOccurred()
                            }) {
                                Image(systemName: "arrow.up")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.2), radius: 5)
                            }
                            .padding(.trailing, 20)
                            .padding(.bottom, 20)
                            .transition(.scale.combined(with: .opacity))
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden)
            .alert("Error", isPresented: $showError) {
                Button("Retry") {
                    Task {
                        await refreshEvents()
                    }
                }
            } message: {
                Text(loadingError?.localizedDescription ?? "An error occurred")
            }
            .task {
                if events.isEmpty {
                    await loadInitialEvents()
                }
            }
            .navigationDestination(for: String.self) { eventId in
                if let event = EventManager.shared.getEvent(id: eventId) {
                    EventDetailScreen(homeStack: $homeStack, event: event)
                }
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .top)
        .background(Color(UIColor.systemBackground))
    }
    
    private func toggleCategory(_ category: String) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
        
        // Save to UserDefaults
        if let encoded = try? JSONEncoder().encode(selectedCategories) {
            savedCategoriesData = encoded
        }
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    private func loadInitialEvents() async {
        isLoading = true
        do {
            events = try await EventService.loadEvents(page: 1)
            currentPage = 1
            hasMorePages = true
        } catch {
            loadingError = error
            showError = true
        }
        isLoading = false
    }
    
    private func loadMoreEvents() async {
        guard !isLoading && hasMorePages else { return }
        
        isLoading = true
        do {
            let nextPage = currentPage + 1
            let newEvents = try await EventService.loadEvents(page: nextPage)
            
            if !newEvents.isEmpty {
                events.append(contentsOf: newEvents)
                currentPage = nextPage
            } else {
                hasMorePages = false
            }
        } catch {
            loadingError = error
            showError = true
        }
        isLoading = false
    }
    
    private func refreshEvents() async {
        await loadInitialEvents()
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            Text("No events found")
                .foregroundColor(.gray)
                .font(.system(size: 16, weight: .medium))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}

struct FilterView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedCategories: Set<String>
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Filter by Category")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                        .padding(.horizontal)
                    
                    // Add more filter options here
                }
                .padding(.top)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Apply") {
                        dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
            .background(Color.black)
        }
    }
}

struct CategoryItem: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
}

struct CategoryCard: View {
    let category: CategoryItem
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                if category.name == "Food & Drinks" {
                    // Clean, modern food icon
                    Circle()
                        .fill(Color(hex: "FF8C00"))  // Dark orange background
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "fork.knife")
                                .font(.system(size: 24))
                                .foregroundColor(.black)  // Black icon
                        )
                } else if category.name == "Music & Concerts" {
                    // Modern music icon with radiating lines
                    ZStack {
                        // Radiating lines
                        ForEach(0..<48) { index in
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 2, height: 8)
                                .offset(y: -25)
                                .rotationEffect(.degrees(Double(index) * 7.5))
                        }
                        
                        // Center circle with music note
                        Circle()
                            .fill(Color(hex: "1E90FF"))  // Deep blue background
                            .frame(width: 50, height: 50)
                            .overlay(
                                Image(systemName: "music.note")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            )
                    }
                    .frame(width: 50, height: 50)
                } else if category.name == "Nightlife" {
                    // Special moon and stars icon
                    Circle()
                        .fill(Color.black)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "moon.stars.fill")
                                .font(.system(size: 24))
                                .foregroundStyle(
                                    .linearGradient(
                                        colors: [
                                            Color(hex: "FFF4E3"),  // Warm moon glow
                                            Color(hex: "FFE5B4"),  // Peach moon
                                            Color(hex: "FFD700"),  // Golden stars
                                            Color(hex: "FFFF00")   // Bright stars
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )
                } else if category.name == "Community" {
                    // Modern community icon
                    Circle()
                        .fill(Color(hex: "20B2AA"))  // Light Sea Green
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "person.3.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .offset(y: 2)
                        )
                } else if category.name == "Arts & Culture" {
                    // Modern paint palette icon
                    Circle()
                        .fill(Color(hex: "FF4500"))  // Vibrant orange-red background
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "paintpalette.fill")
                                .font(.system(size: 24))
                                .foregroundStyle(
                                    .linearGradient(
                                        colors: [
                                            Color(hex: "FF0000"),  // Red
                                            Color(hex: "4169E1"),  // Royal Blue
                                            Color(hex: "FFD700"),  // Gold
                                            Color(hex: "32CD32"),  // Lime Green
                                            Color(hex: "FF1493"),  // Deep Pink
                                            Color(hex: "9370DB")   // Medium Purple
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )
                } else if category.name == "Markets" {
                    // Modern markets icon with leaf
                    Circle()
                        .fill(Color(hex: "2E8B57"))  // Sea green background
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)  // White icon
                                .rotationEffect(.degrees(-45))  // Rotate leaf to match reference
                        )
                } else if category.name == "Sports" {
                    // Modern sports icon with running figure
                    Circle()
                        .fill(Color(hex: "1E90FF"))  // Dodger blue background
                        .frame(width: 50, height: 50)
                        .overlay(
                            ZStack {
                                // White line at bottom - shortened to stay within circle
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 40, height: 2)  // Added width constraint
                                    .offset(y: 15)
                                
                                // Running figure
                                Image(systemName: "figure.run")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                    .offset(y: -2)  // Move figure up slightly above the line
                            }
                        )
                } else if category.name == "Comedy" {
                    // Modern comedy icon with smiling face
                    Circle()
                        .fill(Color(hex: "FFD700"))  // Golden yellow background
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "face.smiling.fill")
                                .font(.system(size: 28))  // Increased size from 24 to 28
                                .foregroundStyle(
                                    Color.black.opacity(0.8)  // Changed from white to semi-opaque black
                                )
                                .offset(y: 1)
                        )
                } else if category.name == "Theater" {
                    // Modern theater masks icon
                    Circle()
                        .fill(Color(hex: "800020"))  // Burgundy/wine red background
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "theatermasks.fill")
                                .font(.system(size: 24))
                                .foregroundStyle(.white)  // White icon
                                .offset(y: 1)  // Slight adjustment to center the icon
                        )
                } else if category.name == "Family Fun" {
                    // Family group icon
                    Circle()
                        .fill(Color(hex: "00CED1"))  // Turquoise background
                        .frame(width: 50, height: 50)
                        .overlay(
                            ZStack {
                                // Adult figures
                                Image(systemName: "figure.stand")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                    .offset(x: -8)
                                
                                Image(systemName: "figure.dress")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                
                                // Child figure
                                Image(systemName: "figure.child")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .offset(x: 8)
                            }
                        )
                } else if category.name == "Workshops" {
                    // Modern workshops icon with gear and tools
                    Circle()
                        .fill(Color(hex: "D2691E"))  // Changed to Chocolate brown
                        .frame(width: 50, height: 50)
                        .overlay(
                            ZStack {
                                // Large gear in background
                                Image(systemName: "gear")
                                    .font(.system(size: 32))
                                    .foregroundColor(.white)
                                    .rotationEffect(.degrees(22.5))  // Rotate for better tooth alignment
                                
                                // Smaller gear overlapping
                                Image(systemName: "gear")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .offset(x: 8, y: 8)  // Position in bottom right
                                    .rotationEffect(.degrees(-22.5))  // Counter-rotate
                                
                                // Tools in center
                                Image(systemName: "wrench.and.screwdriver")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .offset(x: -2, y: -2)  // Position slightly up and left
                            }
                        )
                } else if category.name == "Charity" {
                    // Modern charity icon with hand and heart
                    Circle()
                        .fill(Color(hex: "9B2D86"))  // Rich purple background
                        .frame(width: 50, height: 50)
                        .overlay(
                            ZStack {
                                // Heart floating above hand
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .offset(y: -8)  // Position heart above hand
                                
                                // Open hand reaching up
                                Image(systemName: "hand.raised.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                    .offset(y: 4)  // Position hand slightly lower
                            }
                        )
                } else {
                    // Regular category icon
                    Circle()
                        .fill(category.color.opacity(0.2))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: category.icon)
                                .font(.system(size: 24))
                                .foregroundColor(category.color)
                        )
                }
                
                Text(category.name)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(isSelected ? category.color.opacity(0.2) : Color.white.opacity(0.05))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? category.color : Color.white.opacity(0.5), lineWidth: 1)
            )
        }
    }
}

#Preview {
    NavigationStack {
        DiscoverScreen(homeStack: .constant(NavigationPath()))
    }
    .preferredColorScheme(.dark)
}

// Add this preference key to track scroll offset
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
