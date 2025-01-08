struct PostEventScreen: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var eventManager = EventManager.shared
    
    // State variables
    @State private var eventName = ""
    @State private var selectedDate = Date()
    @State private var venueName = ""
    @State private var area = ""
    @State private var address = ""
    @State private var selectedCategory = "Food & Drinks"  // Default category
    @State private var latitude: Double = 42.2917  // Default Kzoo coordinates
    @State private var longitude: Double = -85.5872
    @State private var showingAlert = false
    @State private var showingValidationAlert = false // Added for validation alert
    
    // Categories matching DiscoverScreen
    let categories = [
        "Food & Drinks", "Music & Concerts", "Nightlife", "Community",
        "Arts & Culture", "Markets", "Sports", "Comedy", "Theater",
        "Family Fun", "Workshops", "Charity"
    ]
    
    // Form validation
    private var isFormValid: Bool {
        let valid = !eventName.isEmpty && !venueName.isEmpty && !area.isEmpty && !address.isEmpty
        print("🔍 Form validation:")
        print("Event name: \(eventName.isEmpty ? "❌" : "✅")")
        print("Venue name: \(venueName.isEmpty ? "❌" : "✅")")
        print("Area: \(area.isEmpty ? "❌" : "✅")")
        print("Address: \(address.isEmpty ? "❌" : "✅")")
        print("Form is \(valid ? "valid ✅" : "invalid ❌")")
        return valid
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Event Name", text: $eventName)
                        .onChange(of: eventName) { _ in print("Event name changed: \(eventName)") }
                    DatePicker("Date & Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                }
                
                Section(header: Text("Location")) {
                    TextField("Venue Name", text: $venueName)
                    TextField("Area", text: $area)
                    TextField("Address", text: $address)
                }
            }
            .navigationTitle("Post Event")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        print("🔘 DEBUG: Post button tapped")
                        
                        // Create a simple test event
                        let testEvent = Event(
                            name: "Test Event",
                            date: "1/9 @ 7 PM",
                            location: Location(
                                name: "Test Venue",
                                area: "Downtown",
                                city: "Kalamazoo",
                                fullAddress: "123 Test St",
                                latitude: 42.2917,
                                longitude: -85.5872
                            ),
                            category: "Food & Drinks"
                        )
                        
                        print("🔴 DEBUG: Created test event")
                        eventManager.submitEvent(testEvent)
                        print("🔴 DEBUG: Submitted test event")
                        showingAlert = true
                    }
                    // Remove the disabled modifier temporarily for testing
                    //.disabled(!isFormValid)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Event Posted!", isPresented: $showingAlert) {
                Button("OK") {
                    print("🔴 DEBUG: Alert OK tapped")
                    dismiss()
                }
            } message: {
                Text("Your event has been successfully posted.")
            }
            .alert("Missing Information", isPresented: $showingValidationAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please fill in all required fields: Event Name, Venue Name, Area, and Address")
            }
        }
    }
}