import SwiftUI
import MapKit
import CoreLocation
import EventKit

struct EventDetailScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @Binding var homeStack: NavigationPath
    let event: Event
    @State private var showingMap = false
    @State private var animateContent = false
    @State private var showingCalendarAlert = false
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: 0) {
                    // Hero Section
                    ZStack(alignment: .bottom) {
                        // Refined Category Icon
                        VStack(spacing: 12) { // Reduced spacing from 16 to 12
                            // Category Icon
                            Circle()
                                .fill(Color(hex: categoryColors[event.category]  ?? "4ECDC4"))
                                .frame(width: 120, height: 120) // Reduced from 150 to 120
                                .overlay(
                                    Group {
                                        switch event.category {
                                        case "Food & Drinks":
                                            Image(systemName: "fork.knife")
                                                .font(.system(size: 40)) // Reduced from 50
                                                .foregroundColor(.black)
                                                
                                        case "Music & Concerts":
                                            ZStack {
                                                // Radiating lines
                                                ForEach(0..<48) { index in
                                                    Rectangle()
                                                        .fill(Color.white)
                                                        .frame(width: 1.5, height: 12) // Reduced from 15
                                                        .offset(y: -40) // Reduced from -50
                                                        .rotationEffect(.degrees(Double(index) * 7.5))
                                                }
                                                
                                                Image(systemName: "music.note")
                                                    .font(.system(size: 40)) // Reduced from 50
                                                    .foregroundColor(.white)
                                            }
                                            
                                        case "Sports":
                                            ZStack {
                                                Rectangle()
                                                    .fill(Color.white)
                                                    .frame(width: 65, height: 1.5) // Reduced from 80
                                                    .offset(y: 25) // Reduced from 30
                                                
                                                Image(systemName: "figure.run")
                                                    .font(.system(size: 40)) // Reduced from 50
                                                    .foregroundColor(.white)
                                                    .offset(y: -4) // Reduced from -5
                                            }
                                            
                                        case "Comedy":
                                            Circle()
                                                .fill(Color(hex: "FFD700"))
                                                .frame(width: 120, height: 120) // Reduced from 150
                                                .overlay(
                                                    Image(systemName: "face.smiling.fill")
                                                        .font(.system(size: 50)) // Reduced from 60
                                                        .foregroundStyle(
                                                            Color.black.opacity(0.8)
                                                        )
                                                        .offset(y: 2)
                                                )
                                            
                                        case "Arts & Culture":
                                            Image(systemName: "paintpalette.fill")
                                                .font(.system(size: 40)) // Reduced from 50
                                                .foregroundStyle(
                                                    .linearGradient(
                                                        colors: [
                                                            Color(hex: "FF0000"),
                                                            Color(hex: "4169E1"),
                                                            Color(hex: "FFD700"),
                                                            Color(hex: "32CD32"),
                                                            Color(hex: "FF1493"),
                                                            Color(hex: "9370DB")
                                                        ],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    )
                                                )
                                            
                                        case "Markets":
                                            Image(systemName: "leaf.fill")
                                                .font(.system(size: 40)) // Reduced from 50
                                                .foregroundColor(.white)
                                                .rotationEffect(.degrees(-45))
                                            
                                        case "Nightlife":
                                            Image(systemName: "moon.stars.fill")
                                                .font(.system(size: 40)) // Reduced from 50
                                                .foregroundStyle(
                                                    .linearGradient(
                                                        colors: [
                                                            Color(hex: "FFF4E3"),
                                                            Color(hex: "FFE5B4"),
                                                            Color(hex: "FFD700"),
                                                            Color(hex: "FFFF00")
                                                        ],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    )
                                                )
                                            
                                        case "Charity":
                                            ZStack {
                                                Image(systemName: "heart.fill")
                                                    .font(.system(size: 30)) // Reduced from 35
                                                    .foregroundColor(.white)
                                                    .offset(y: -12) // Reduced from -15
                                                
                                                Image(systemName: "hand.raised.fill")
                                                    .font(.system(size: 40)) // Reduced from 50
                                                    .foregroundColor(.white)
                                                    .offset(y: 6) // Reduced from 7
                                            }
                                            
                                        case "Community":
                                            Image(systemName: "person.3.fill")
                                                .font(.system(size: 40)) // Reduced from 50
                                                .foregroundColor(.white)
                                            
                                        case "Workshops":
                                            ZStack {
                                                Image(systemName: "gear")
                                                    .font(.system(size: 55)) // Reduced from 65
                                                    .foregroundColor(.white)
                                                    .rotationEffect(.degrees(22.5))
                                                
                                                Image(systemName: "gear")
                                                    .font(.system(size: 35)) // Reduced from 40
                                                    .foregroundColor(.white)
                                                    .offset(x: 12, y: 12) // Reduced from 15,15
                                                    .rotationEffect(.degrees(-22.5))
                                                
                                                Image(systemName: "wrench.and.screwdriver")
                                                    .font(.system(size: 30)) // Reduced from 35
                                                    .foregroundColor(.white)
                                                    .offset(x: -4, y: -4) // Reduced from -5,-5
                                            }
                                            
                                        case "Family Fun":
                                            ZStack {
                                                Image(systemName: "figure.stand")
                                                    .font(.system(size: 40)) // Reduced from 50
                                                    .foregroundColor(.white)
                                                    .offset(x: -12) // Reduced from -15
                                                
                                                Image(systemName: "figure.dress")
                                                    .font(.system(size: 40)) // Reduced from 50
                                                    .foregroundColor(.white)
                                                
                                                Image(systemName: "figure.child")
                                                    .font(.system(size: 35)) // Reduced from 40
                                                    .foregroundColor(.white)
                                                    .offset(x: 12) // Reduced from 15
                                            }
                                            
                                        case "Theater":
                                            Image(systemName: "theatermasks.fill")
                                                .font(.system(size: 40)) // Reduced from 50
                                                .foregroundColor(.white)
                                            
                                        default:
                                            Image(systemName: categoryIcons[event.category] ?? "star.fill")
                                                .font(.system(size: 40)) // Reduced from 50
                                                .foregroundColor(.white)
                                        }
                                    }
                                )
                                .background(
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                        .shadow(color: .black.opacity(0.2), radius: 15, x: 0, y: 5)
                                )
                                .overlay(
                                    Circle()
                                        .stroke(.white.opacity(0.3), lineWidth: 1)
                                )
                                .padding(.top, 40) // Reduced from 60
                                .scaleEffect(animateContent ? 1 : 0.8)
                                .opacity(animateContent ? 1 : 0)
                            
                            // Refined Title & Category
                            VStack(spacing: 4) { // Reduced from 6
                                Text(event.name)
                                    .font(.system(size: 22, weight: .bold)) // Reduced from 24
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                                    .shadow(color: .black.opacity(0.3), radius: 4, y: 2)
                                
                                Text(event.category)
                                    .font(.system(size: 13, weight: .medium)) // Reduced from 14
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10) // Reduced from 12
                                    .padding(.vertical, 4) // Reduced from 6
                                    .background(
                                        Capsule()
                                            .fill(.ultraThinMaterial)
                                            .shadow(color: .black.opacity(0.15), radius: 8, y: 2)
                                    )
                            }
                            .padding(.bottom, 4) // Reduced from 6
                            .offset(y: animateContent ? 0 : 20)
                            .opacity(animateContent ? 1 : 0)
                        }
                    }
                    
                    // Event Details
                    VStack(spacing: 2) {
                        // Date & Time Card
                        DetailCard(title: "Date & Time") {
                            Button(action: {
                                addEventToCalendar()
                            }) {
                                HStack {
                                    Image(systemName: "calendar")
                                        .font(.system(size: 24, weight: .light))
                                        .foregroundColor(Color(hex: "4ECDC4"))
                                        .symbolEffect(.bounce, value: animateContent)
                                    
                                    VStack(alignment: .leading) {
                                        Text(formatDateDescription(event.date))
                                            .font(.system(size: 18))
                                            .foregroundColor(.primary.opacity(0.8))
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(Color(hex: "4ECDC4"))
                                        .font(.system(size: 20))
                                        .frame(width: 24, height: 24)
                                        .offset(y: 2)
                                        .shadow(color: Color(hex: "4ECDC4").opacity(0.5), radius: 5)
                                        .symbolEffect(.pulse, value: animateContent)
                                }
                            }
                        }
                        .alert("Add to Calendar", isPresented: $showingCalendarAlert) {
                            Button("Cancel", role: .cancel) { }
                            Button("Add") {
                                requestCalendarAccess()
                            }
                        } message: {
                            Text("Would you like to add this event to your calendar?")
                        }
                        .transition(.move(edge: .leading))
                        
                        // Location Card
                        DetailCard(title: "Location") {
                            Button(action: { 
                                openInMaps()
                            }) {
                                HStack(spacing: 12) {
                                    Image(systemName: "mappin.circle.fill")
                                        .font(.system(size: 24, weight: .light))
                                        .foregroundColor(Color(hex: "FF6B6B"))
                                        .symbolEffect(.pulse, value: animateContent)
                                    
                                    VStack(alignment: .leading, spacing: 4) { // Reduced from 6
                                        Text(event.location.name)
                                            .font(.system(size: 18, weight: .semibold)) // Reduced from 20
                                            .foregroundColor(.primary)
                                            .multilineTextAlignment(.leading)
                                        VStack(alignment: .leading, spacing: 1) { // Reduced from 2
                                            Text(event.location.fullAddress)
                                                .font(.system(size: 13)) // Reduced from 14
                                                .foregroundColor(.secondary)
                                                .multilineTextAlignment(.leading)
                                            
                                            Text("\(event.location.area), \(event.location.city)")
                                                .font(.system(size: 13)) // Reduced from 14
                                                .foregroundColor(.secondary)
                                                .multilineTextAlignment(.leading)
                                        }
                                    }
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color(hex: "FF6B6B"))
                                        .font(.system(size: 20))
                                        .frame(width: 24, height: 24)
                                        .offset(y: 2)
                                        .shadow(color: Color(hex: "FF6B6B").opacity(0.5), radius: 5)
                                        .symbolEffect(.pulse, value: animateContent)
                                }
                            }
                        }
                        .transition(.move(edge: .trailing))
                        
                        // Description Card (if available)
                        if let description = event.description {
                            DetailCard(title: "Description") {
                                Text(description)
                                    .font(.system(size: 15)) // Reduced from 16
                                    .foregroundColor(.primary.opacity(0.8))
                                    .lineSpacing(3) // Reduced from 4
                            }
                            .transition(.move(edge: .trailing))
                            .padding(.bottom, 8) // Reduced from 12
                        }
                    }
                    .padding(16) // Reduced from 20
                }
                .padding(.top, 40) // Reduced from 60
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showingMap) {
                MapView(coordinate: CLLocationCoordinate2D(
                    latitude: event.location.coordinate.latitude,
                    longitude: event.location.coordinate.longitude
                ))
                .edgesIgnoringSafeArea(.all)
            }
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    animateContent = true
                }
            }
            
            // Sticky Header
            NavigationHeader(
                dismiss: dismiss,
                shareText: "\(event.name)\nDate: \(event.date)\nLocation: \(event.location.name)"
            )
            .padding(.top, -55)
        }
    }
    
    private func formatDateDescription(_ dateString: String) -> String {
        // Since our dates are in format "1/13 @ 11 AM", let's just return it directly
        return dateString
        
        /* Remove or comment out the old implementation
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
         
        guard let date = dateFormatter.date(from: dateString) else {
            return dateString
        }
        
        dateFormatter.dateFormat = "EEEE, MMMM d 'at' h:mm a"
        return dateFormatter.string(from: date)
        */
    }
    
    private func addEventToCalendar() {
        showingCalendarAlert = true
    }
    
    private func requestCalendarAccess() {
        let eventStore = EKEventStore()
        
        if #available(iOS 17.0, *) {
            Task {
                do {
                    try await eventStore.requestFullAccessToEvents()
                    await createCalendarEvent(store: eventStore)
                } catch {
                    print("Failed to request calendar access: \(error)")
                }
            }
        } else {
            eventStore.requestAccess(to: .event) { granted, error in
                if granted {
                    createCalendarEvent(store: eventStore)
                }
            }
        }
    }
    
    private func createCalendarEvent(store: EKEventStore) {
        let calendarEvent = EKEvent(eventStore: store)
        calendarEvent.title = event.name
        calendarEvent.location = event.location.fullAddress
        
        // Parse the date string to create start and end times
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd '@' h a"
        
        if let startDate = dateFormatter.date(from: event.date) {
            calendarEvent.startDate = startDate
            // Set end date to 2 hours after start by default
            calendarEvent.endDate = startDate.addingTimeInterval(2 * 60 * 60)
            
            do {
                try store.save(calendarEvent, span: .thisEvent)
            } catch {
                print("Failed to save event to calendar: \(error)")
            }
        }
    }
    
    private func openInMaps() {
        let address = event.location.fullAddress.replacingOccurrences(of: " ", with: "+")
        
        // Create URL for Apple Maps
        let appleMapsURL = URL(string: "maps://?address=\(address)")
        
        // Create URL for Google Maps
        let googleMapsURL = URL(string: "comgooglemaps://?q=\(address)")
        
        // Create fallback URL for Google Maps web
        let googleMapsWebURL = URL(string: "https://www.google.com/maps/search/?api=1&query=\(address)")
        
        let alert = UIAlertController(title: "Open in Maps", message: "Choose your preferred maps application", preferredStyle: .actionSheet)
        
        // Add Apple Maps option
        if let appleMapsURL = appleMapsURL, UIApplication.shared.canOpenURL(appleMapsURL) {
            alert.addAction(UIAlertAction(title: "Apple Maps", style: .default) { _ in
                UIApplication.shared.open(appleMapsURL)
            })
        }
        
        // Add Google Maps option
        if let googleMapsURL = googleMapsURL, UIApplication.shared.canOpenURL(googleMapsURL) {
            alert.addAction(UIAlertAction(title: "Google Maps", style: .default) { _ in
                UIApplication.shared.open(googleMapsURL)
            })
        } else if let googleMapsWebURL = googleMapsWebURL {
            alert.addAction(UIAlertAction(title: "Google Maps", style: .default) { _ in
                UIApplication.shared.open(googleMapsWebURL)
            })
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // Present the alert
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let viewController = windowScene.windows.first?.rootViewController {
            viewController.present(alert, animated: true)
        }
    }
}

struct DetailCard<Content: View>: View {
    let title: String
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) { // Reduced from 16
            Text(title)
                .font(.system(size: 14, weight: .semibold)) // Reduced from 16
                .foregroundColor(.secondary)
                .textCase(.uppercase)
                .tracking(0.5)
            
            content()
        }
        .padding(16) // Reduced from 20
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(16) // Reduced from 20
        .shadow(color: .black.opacity(0.08), radius: 15, y: 8)
    }
}

struct SpringButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

struct MapView: View {
    let coordinate: CLLocationCoordinate2D
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: .constant(MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                        .font(.system(size: 16, weight: .medium))
                }
            }
        }
    }
}

// Category Icons and Colors - Update to match DiscoverScreen
private let categoryIcons = [
    "Food & Drinks": "fork.knife",
    "Music & Concerts": "music.note.list",
    "Nightlife": "moon.stars.fill",
    "Community": "person.3.fill",
    "Arts & Culture": "paintpalette.fill",
    "Markets": "leaf.fill",
    "Sports": "figure.run",
    "Comedy": "face.smiling.fill",
    "Theater": "theatermasks.fill",
    "Family Fun": "figure.2.and.child",
    "Workshops": "hammer.fill",
    "Charity": "hand.raised.fill"
]

private let categoryColors = [
    "Food & Drinks": "FF8C00",
    "Music & Concerts": "8A2BE2",
    "Nightlife": "000000",
    "Community": "20B2AA",
    "Arts & Culture": "FF4500",
    "Markets": "2E8B57",
    "Sports": "4169E1",
    "Comedy": "FFD700",
    "Theater": "800020",
    "Family Fun": "00CED1",
    "Workshops": "D2691E",
    "Charity": "9B2D86"
]

#Preview {
    EventDetailScreen(
        homeStack: .constant(NavigationPath()),
        event: Event(
            name: "Food Truck Rally",
            date: "1/13 @ 11 AM",
            location: Location(
                name: "Bronson Park",
                area: "Downtown",
                city: "Kalamazoo",
                fullAddress: "200 S Rose St, Kalamazoo, MI 49007",
                latitude: 42.2916,
                longitude: -85.5859
            ),
            category: "Food & Drinks",
            description: "Join us for a delicious gathering of Kalamazoo's best food trucks featuring local cuisine and street food favorites."
        )
    )
    .preferredColorScheme(.dark)
}

// Alternative preview with multiple color schemes
struct EventDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EventDetailScreen(
                homeStack: .constant(NavigationPath()),
                event: Event(
                    name: "Food Truck Rally",
                    date: "1/13 @ 11 AM",
                    location: Location(
                        name: "Bronson Park",
                        area: "Downtown",
                        city: "Kalamazoo",
                        fullAddress: "200 S Rose St, Kalamazoo, MI 49007",
                        latitude: 42.2916,
                        longitude: -85.5859
                    ),
                    category: "Food & Drinks",
                    description: "Join us for a delicious gathering of Kalamazoo's best food trucks featuring local cuisine and street food favorites."
                )
            )
            .preferredColorScheme(.dark)
            
            EventDetailScreen(
                homeStack: .constant(NavigationPath()),
                event: Event(
                    name: "Food Truck Rally",
                    date: "1/13 @ 11 AM",
                    location: Location(
                        name: "Bronson Park",
                        area: "Downtown",
                        city: "Kalamazoo",
                        fullAddress: "200 S Rose St, Kalamazoo, MI 49007",
                        latitude: 42.2916,
                        longitude: -85.5859
                    ),
                    category: "Food & Drinks",
                    description: "Join us for a delicious gathering of Kalamazoo's best food trucks featuring local cuisine and street food favorites."
                )
            )
            .preferredColorScheme(.light)
        }
    }
}