    import SwiftUI
    import MapKit
    import CoreLocation
    
    struct EventDetailScreen: View {
        @Environment(\.dismiss) var dismiss
        @Environment(\.colorScheme) var colorScheme
        let event: Event
        @State private var showingMap = false
        @State private var animateContent = false
        
        var body: some View {
            VStack(spacing: 0) {
                // Back Button
                HStack {
                    Button(action: { dismiss() }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 14, weight: .semibold))
                            Text("Back")
                                .font(.system(size: 16, weight: .medium))
                        }
                        .foregroundColor(.primary)
                    }
                    .padding(.leading)
                    Spacer()
                }
                .padding(.top, 8)
                
                // Hero Section
                ZStack(alignment: .bottom) {
                    // Elegant Gradient Background
                    Rectangle()
                        .fill(LinearGradient(
                            colors: [
                                Color(hex: categoryColors[event.category] ?? "4ECDC4").opacity(0.9),
                                Color(hex: colorScheme == .dark ? "1A1A1A" : "FAFAFA")
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(height: 320)
                        .overlay(
                            Color.black.opacity(0.2) // Subtle overlay for depth
                        )
                    
                    // Refined Category Icon
                    VStack(spacing: 20) {
                        // Category Icon
                        Circle()
                            .fill(Color(hex: categoryColors[event.category] ?? "4ECDC4"))
                            .frame(width: 110, height: 110)
                            .overlay(
                                Group {
                                    switch event.category {
                                    case "Food & Drinks":
                                        Image(systemName: "fork.knife")
                                            .font(.system(size: 50))
                                            .foregroundColor(.black)
                                            
                                    case "Music & Concerts":
                                        ZStack {
                                            ForEach(0..<48) { index in
                                                Rectangle()
                                                    .fill(Color.white)
                                                    .frame(width: 2, height: 12)
                                                    .offset(y: -40)
                                                    .rotationEffect(.degrees(Double(index) * 7.5))
                                            }
                                            
                                            Image(systemName: "music.note")
                                                .font(.system(size: 50))
                                                .foregroundColor(.white)
                                        }
                                        
                                    case "Nightlife":
                                        Image(systemName: "moon.stars.fill")
                                            .font(.system(size: 50))
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
                                        
                                    // Add all other cases from EventListItem.swift...
                                    default:
                                        Image(systemName: categoryIcons[event.category] ?? "star.fill")
                                            .font(.system(size: 50))
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
                            .scaleEffect(animateContent ? 1 : 0.8)
                            .opacity(animateContent ? 1 : 0)
                        
                        // Refined Title & Category
                        VStack(spacing: 16) {
                            Text(event.name)
                                .font(.system(size: 34, weight: .bold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .shadow(color: .black.opacity(0.3), radius: 4, y: 2)
                            
                            Text(event.category)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(
                                    Capsule()
                                        .fill(.ultraThinMaterial)
                                        .shadow(color: .black.opacity(0.15), radius: 8, y: 2)
                                )
                        }
                        .padding(.bottom, 32)
                        .offset(y: animateContent ? 0 : 20)
                        .opacity(animateContent ? 1 : 0)
                    }
                }
                
                // Event Details
                VStack(spacing: 28) {
                    // Date & Time Card
                    DetailCard(title: "Date & Time") {
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
                        }
                    }
                    .transition(.move(edge: .leading))
                    
                    // Location Card
                    DetailCard(title: "Location") {
                        Button(action: { 
                            withAnimation(.spring()) {
                                showingMap = true 
                            }
                        }) {
                            HStack {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.system(size: 24, weight: .light))
                                    .foregroundColor(Color(hex: "FF6B6B"))
                                    .symbolEffect(.pulse, value: animateContent)
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(event.location.name)
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.primary)
                                    Text(event.location.fullAddress)
                                        .font(.system(size: 14))
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                                    .font(.system(size: 14, weight: .semibold))
                            }
                        }
                    }
                    .transition(.move(edge: .trailing))
                    .padding(.bottom, 20)
                    
                    HStack(spacing: 16) {
                        // Share Button
                        Button(action: shareEvent) {
                            HStack(spacing: 12) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("Share Event")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: "4A90E2"), Color(hex: "357ABD")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(16)
                            .shadow(color: Color(hex: "4A90E2").opacity(0.3), radius: 8, y: 4)
                        }
                        .buttonStyle(SpringButtonStyle())
                    }
                    .padding(.bottom, 40)
                }
                .padding(24)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: shareEvent) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 16, weight: .medium))
                    }
                }
            }
            .sheet(isPresented: $showingMap) {
                MapView(coordinate: CLLocationCoordinate2D(
                ))
                .edgesIgnoringSafeArea(.all)
            }
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    animateContent = true
                }
            }
        }
        
        private func shareEvent() {
            let eventText = """
            Check out this event!
            
            \(event.name)
            📅 \(formatDateDescription(event.date))
            📍 \(event.location.name)
            \(event.location.fullAddress)
            """
            
            let activityVC = UIActivityViewController(
                activityItems: [eventText],
                applicationActivities: nil
            )
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first,
               let rootVC = window.rootViewController {
                rootVC.present(activityVC, animated: true)
            }
        }
        
        private func formatDateDescription(_ dateString: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            guard let date = dateFormatter.date(from: dateString) else {
                return dateString
            }
            
            dateFormatter.dateFormat = "EEEE, MMMM d 'at' h:mm a"
            return dateFormatter.string(from: date)
        }
    }
    
    struct DetailCard<Content: View>: View {
        let title: String
        let content: () -> Content
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
                    .tracking(0.5)
                
                content()
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemBackground))
            .cornerRadius(20)
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
        "Music & Concerts": "music.note",
        "Nightlife": "moon.stars.fill",
        "Community": "person.3.fill",
        "Arts & Culture": "paintpalette.fill",
        "Markets": "leaf.fill",
        "Sports": "figure.run",
        "Comedy": "face.smiling.fill",
        "Theater": "theatermasks.fill",
        "Family Fun": "figure.2.and.child.holdinghands",
        "Workshops": "hammer.fill",
        "Charity": "heart.fill"
    ]
    
    private let categoryColors = [
        "Food & Drinks": "FF8C00",
        "Music & Concerts": "8A2BE2",
        "Nightlife": "191970",
        "Community": "20B2AA",
        "Arts & Culture": "FF4500",
        "Markets": "32CD32",
        "Sports": "4169E1",
        "Comedy": "FFD700",
        "Theater": "DC143C",
        "Family Fun": "00CED1",
        "Workshops": "D2691E",
        "Charity": "9370DB"
    ]