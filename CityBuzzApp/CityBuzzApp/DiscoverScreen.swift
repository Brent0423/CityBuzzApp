import SwiftUI
// No need to explicitly import Event since it's part of the main target

// Event model will be shared from HomeScreen.swift

struct DiscoverScreen: View {
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
    @Namespace private var scrollSpace
    
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
        CategoryItem(name: "Food & Drinks", icon: "fork.knife", color: .orange),
        CategoryItem(name: "Music & Concerts", icon: "music.note", color: .purple),
        CategoryItem(name: "Nightlife", icon: "moon.stars.fill", color: .indigo),
        CategoryItem(name: "Community", icon: "person.3.fill", color: .green),
        CategoryItem(name: "Arts & Culture", icon: "paintpalette.fill", color: .pink),
        CategoryItem(name: "Markets", icon: "cart.fill", color: .blue),
        CategoryItem(name: "Sports & Fitness", icon: "figure.run", color: .red),
        CategoryItem(name: "Comedy", icon: "theatermasks.fill", color: .yellow),
        CategoryItem(name: "Theater", icon: "ticket.fill", color: .mint),
        CategoryItem(name: "Family Fun", icon: "heart.fill", color: .cyan),
        CategoryItem(name: "Workshops", icon: "pencil", color: .brown),
        CategoryItem(name: "Charity", icon: "hand.raised.fill", color: .teal)
    ]
    
    var filteredEvents: [Event] {
        if searchText.isEmpty && selectedCategories.isEmpty {
            return events
        }
        return events.filter { event in
            let matchesSearch = searchText.isEmpty || 
                event.name.localizedCaseInsensitiveContains(searchText) ||
                event.location.localizedCaseInsensitiveContains(searchText)
            let matchesCategory = selectedCategories.isEmpty || selectedCategories.contains(event.category)
            return matchesSearch && matchesCategory
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 25) {
                        Color.clear
                            .frame(height: 0)
                            .id(scrollSpace)
                        
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
                                
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
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
                                    .padding(.horizontal, 20)
                                
                                if filteredEvents.isEmpty {
                                    EmptyStateView()
                                } else {
                                    LazyVStack(spacing: 15) {
                                        ForEach(filteredEvents) { event in
                                            EventCard(event: event)
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
                                    .padding(.horizontal, 20)
                                
                                if filteredEvents.isEmpty {
                                    EmptyStateView()
                                } else {
                                    LazyVStack(spacing: 15) {
                                        ForEach(filteredEvents) { event in
                                            EventCard(event: event)
                                        }
                                    }
                                    .padding(.horizontal, 20)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 20)
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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Discover")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .background(Color.black)
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
        }
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
                Circle()
                    .fill(category.color.opacity(0.2))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: category.icon)
                            .font(.system(size: 24))
                            .foregroundColor(category.color)
                    )
                
                Text(category.name)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(isSelected ? category.color.opacity(0.2) : Color.white.opacity(0.05))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? category.color : Color.white.opacity(0.1), lineWidth: 1)
            )
        }
    }
}

struct RecommendedEventCard: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Event Image/Icon
            Circle()
                .fill(LinearGradient(
                    gradient: Gradient(colors: [.blue, .blue.opacity(0.7)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 70, height: 70)
                .overlay(
                    Image(systemName: event.image)
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                )
            
            // Event Details
            VStack(alignment: .leading, spacing: 8) {
                Text(event.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                
                Text(event.date)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Text(event.location)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 160)
        .padding(16)
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
}

struct DiscoverScreen_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverScreen()
    }
}

// Add this preference key to track scroll offset
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
} 