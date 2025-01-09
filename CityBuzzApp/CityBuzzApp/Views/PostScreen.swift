import SwiftUI

struct PostScreen: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var eventManager = EventManager.shared
    
    // State variables
    @State private var eventName = ""
    @State private var selectedDate = Date()
    @State private var venueName = ""
    @State private var area = ""
    @State private var address = ""
    @State private var selectedCategory = "Food & Drinks"  // Default category
    @State private var description = ""  // Added description field
    @State private var latitude: Double = 42.2917  // Default Kzoo coordinates
    @State private var longitude: Double = -85.5872
    @State private var showingAlert = false
    @State private var showingValidationAlert = false
    
    // Categories matching DiscoverScreen
    let categories = [
        "Food & Drinks", "Music & Concerts", "Nightlife", "Community",
        "Arts & Culture", "Markets", "Sports", "Comedy", "Theater",
        "Family Fun", "Workshops", "Charity"
    ]
    
    // Form validation
    private var isFormValid: Bool {
        !eventName.isEmpty && !venueName.isEmpty && !area.isEmpty && !address.isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Event Name", text: $eventName)
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
                
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                        .frame(height: 100)
                }
            }
            .navigationTitle("Post Event")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        if !isFormValid {
                            showingValidationAlert = true
                            return
                        }
                        
                        // Format date string
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "M/dd '@' h a"
                        let formattedDate = dateFormatter.string(from: selectedDate)
                        
                        let newEvent = Event(
                            name: eventName,
                            date: formattedDate,
                            location: Location(
                                name: venueName,
                                area: area,
                                city: "Kalamazoo",
                                fullAddress: address,
                                latitude: latitude,
                                longitude: longitude
                            ),
                            category: selectedCategory,
                            description: description.isEmpty ? nil : description
                        )
                        
                        eventManager.submitEvent(newEvent)
                        showingAlert = true
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Event Posted!", isPresented: $showingAlert) {
                Button("OK") {
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

#Preview {
    PostScreen()
}