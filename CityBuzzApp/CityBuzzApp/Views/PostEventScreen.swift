import SwiftUI
import MapKit
import PhotosUI

// MARK: - Form Components
struct EventInfoHeader: View {
    var body: some View {
        Text("Event Info")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.bottom, 8)
    }
}

struct DateTimeSection: View {
    @Binding var selectedDate: Date
    @Binding var selectedTime: Date
    let accentColor: Color
    
    var body: some View {
        HStack(spacing: 16) {
            // Date Picker
            VStack(alignment: .leading) {
                Text("Date")
                    .foregroundColor(.gray)
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .tint(.white)
            }
            .frame(maxWidth: .infinity)
            
            // Time Picker
            VStack(alignment: .leading) {
                Text("Time")
                    .foregroundColor(.gray)
                DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .tint(.white)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct ImageUploadSection: View {
    @Binding var selectedImage: PhotosPickerItem?
    @Binding var selectedImageData: Data?
    let accentColor: Color
    
    var body: some View {
        PhotosPicker(selection: $selectedImage, matching: .images) {
            if let selectedImageData,
               let uiImage = UIImage(data: selectedImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white, lineWidth: 2)
                    )
            } else {
                HStack {
                    Image(systemName: "photo.fill")
                        .font(.title2)
                    Text("Add Event Photo")
                        .fontWeight(.medium)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .background(Color.black.opacity(0.3))
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(style: StrokeStyle(dash: [8]))
                        .foregroundColor(.white.opacity(0.5))
                        .frame(minWidth: 2)
                )
            }
        }
    }
}

// MARK: - Main View
struct PostEventScreen: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var locationManager = LocationSearchManager()
    
    @State private var eventTitle = ""
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var location = ""
    @State private var selectedCategory = "Community"
    @State private var description = ""
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var showingCategoryPicker = false
    @State private var showLocationResults = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    let accentColor = Color.white
    let gradientColors = [Color.black, Color.black]
    
    private func validateForm() -> Bool {
        if eventTitle.isEmpty {
            errorMessage = "Please enter an event title"
            showError = true
            return false
        }
        
        if location.isEmpty {
            errorMessage = "Please select a location"
            showError = true
            return false
        }
        
        if description.isEmpty {
            errorMessage = "Please add a description"
            showError = true
            return false
        }
        
        return true
    }
    
    private func createEvent() {
        if validateForm() {
            // Format date and time
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M/dd '@' h a"
            let combinedDate = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: selectedTime),
                                                   minute: Calendar.current.component(.minute, from: selectedTime),
                                                   second: 0,
                                                   of: selectedDate) ?? Date()
            let formattedDate = dateFormatter.string(from: combinedDate)
            
            // Create location object
            let eventLocation = Location(name: location.components(separatedBy: ",")[0],
                                      area: "Downtown", // Default for now
                                      city: "Kalamazoo", // Default for now
                                      fullAddress: location)
            
            // Create new event
            let newEvent = Event(name: eventTitle,
                               date: formattedDate,
                               location: eventLocation,
                               image: "calendar", // Default icon for now
                               category: selectedCategory)
            
            // Here you would typically save the event to your data store
            // For now we'll just print and dismiss
            print("Created new event: \(newEvent)")
            dismiss()
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    GroupBox {
                        VStack(alignment: .leading, spacing: 24) {
                            EventInfoHeader()
                            
                            InputField(title: "Title", text: $eventTitle, icon: "pencil")
                            
                            DateTimeSection(
                                selectedDate: $selectedDate,
                                selectedTime: $selectedTime,
                                accentColor: accentColor
                            )
                            
                            // Location Search
                            locationSection
                            
                            // Category Selection
                            categorySection
                            
                            // Description
                            descriptionSection
                            
                            ImageUploadSection(
                                selectedImage: $selectedImage,
                                selectedImageData: $selectedImageData,
                                accentColor: accentColor
                            )
                            .onChange(of: selectedImage) { newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        selectedImageData = data
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    .groupBoxStyle(GlassGroupBoxStyle(accentColor: accentColor))
                }
                .padding()
            }
            .navigationTitle("Create Event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                toolbarContent
            }
            .sheet(isPresented: $showingCategoryPicker) {
                CategoryPickerView(selectedCategory: $selectedCategory)
            }
            .background(
                LinearGradient(
                    colors: gradientColors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .alert("Error", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Location")
                .foregroundColor(.gray)
            TextField("Enter location...", text: $locationManager.searchQuery)
                .textFieldStyle(ModernTextFieldStyle(icon: "mappin.circle.fill"))
                .onChange(of: locationManager.searchQuery) { query in
                    withAnimation { showLocationResults = !query.isEmpty }
                }
            
            if showLocationResults && !locationManager.searchResults.isEmpty {
                LocationResultsView(
                    results: locationManager.searchResults,
                    onSelect: { result in
                        location = result.title + (result.subtitle.isEmpty ? "" : ", " + result.subtitle)
                        locationManager.searchQuery = location
                        showLocationResults = false
                    }
                )
            }
        }
    }
    
    private var categorySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Category")
                .foregroundColor(.gray)
            Button(action: { showingCategoryPicker.toggle() }) {
                HStack {
                    Image(systemName: "tag.fill")
                        .foregroundColor(.white)
                    Text(selectedCategory)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(showingCategoryPicker ? 90 : 0))
                }
                .padding()
                .background(Color.black.opacity(0.3))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.white.opacity(0.5), lineWidth: 1)
                )
            }
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Description")
                .foregroundColor(.gray)
            TextEditor(text: $description)
                .frame(height: 120)
                .padding(8)
                .background(Color.black.opacity(0.3))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.white.opacity(0.5), lineWidth: 1)
                )
        }
    }
    
    private var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") { dismiss() }
                    .foregroundColor(.gray)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: createEvent) {
                    Text("Post")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(.white)
                        .cornerRadius(20)
                }
            }
        }
    }
}

struct ModernTextFieldStyle: TextFieldStyle {
    let icon: String
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
            configuration
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.black.opacity(0.3))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.white.opacity(0.5), lineWidth: 1)
        )
    }
}

struct LocationResultsView: View {
    let results: [MKLocalSearchCompletion]
    let onSelect: (MKLocalSearchCompletion) -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(results, id: \.self) { result in
                    Button(action: { onSelect(result) }) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(result.title)
                                .foregroundColor(.white)
                            Text(result.subtitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                    
                    if result != results.last {
                        Divider()
                            .background(.white.opacity(0.3))
                    }
                }
            }
            .padding()
        }
        .frame(maxHeight: 200)
        .background(Color.black.opacity(0.3))
        .cornerRadius(12)
    }
}

struct GlassGroupBoxStyle: GroupBoxStyle {
    let accentColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.content
        }
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.2))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.3), lineWidth: 1)
        )
    }
}

struct InputField: View {
    let title: String
    @Binding var text: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundColor(.gray)
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                TextField(title, text: $text)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.black.opacity(0.3))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.white.opacity(0.5), lineWidth: 1)
            )
        }
    }
}

// Add preview provider
#Preview {
    PostEventScreen()
        .preferredColorScheme(.dark)
}