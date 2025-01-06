import SwiftUI
import MapKit
import Combine

struct PostEventScreen: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var locationManager = LocationSearchManager()
    
    @State private var eventTitle = ""
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var location = ""
    @State private var selectedCategory = "Community"
    @State private var showingCategoryPicker = false
    @State private var showLocationResults = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Event Info Section
                    GroupBox {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Event Info")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            // Title Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Title")
                                    .foregroundColor(.gray)
                                TextField("Enter the event title...", text: $eventTitle)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .foregroundColor(.white)
                            }
                            
                            // Date Picker
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Date")
                                    .foregroundColor(.gray)
                                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                                    .datePickerStyle(.compact)
                                    .labelsHidden()
                                    .colorScheme(.dark)
                            }
                            
                            // Time Picker
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Time")
                                    .foregroundColor(.gray)
                                DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                                    .datePickerStyle(.compact)
                                    .labelsHidden()
                                    .colorScheme(.dark)
                            }
                            
                            // Location Field with Search
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Location")
                                    .foregroundColor(.gray)
                                
                                TextField("Enter location...", text: $locationManager.searchQuery)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .onChange(of: locationManager.searchQuery) { query in
                                        showLocationResults = !query.isEmpty
                                    }
                                
                                if showLocationResults && !locationManager.searchResults.isEmpty {
                                    ScrollView {
                                        VStack(alignment: .leading, spacing: 12) {
                                            ForEach(locationManager.searchResults, id: \.self) { result in
                                                Button(action: {
                                                    location = result.title
                                                    if !result.subtitle.isEmpty {
                                                        location += ", " + result.subtitle
                                                    }
                                                    locationManager.searchQuery = location
                                                    showLocationResults = false
                                                }) {
                                                    VStack(alignment: .leading, spacing: 4) {
                                                        Text(result.title)
                                                            .foregroundColor(.white)
                                                        Text(result.subtitle)
                                                            .font(.caption)
                                                            .foregroundColor(.gray)
                                                    }
                                                }
                                                
                                                if result != locationManager.searchResults.last {
                                                    Divider()
                                                }
                                            }
                                        }
                                        .padding()
                                    }
                                    .frame(maxHeight: 200)
                                    .background(Color.black.opacity(0.8))
                                    .cornerRadius(8)
                                }
                            }
                            
                            // Category Picker
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Category")
                                    .foregroundColor(.gray)
                                Button(action: { showingCategoryPicker.toggle() }) {
                                    HStack {
                                        Text(selectedCategory)
                                            .foregroundColor(.white)
                                        Spacer()
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(.blue)
                                    }
                                    .padding()
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(8)
                                }
                            }
                        }
                        .padding()
                    }
                    .groupBoxStyle(DarkGroupBoxStyle())
                }
                .padding()
            }
            .navigationTitle("Post Event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") { dismiss() }
                }
            }
            .sheet(isPresented: $showingCategoryPicker) {
                CategoryPickerView(selectedCategory: $selectedCategory)
            }
            .background(Color.black)
        }
    }
} 