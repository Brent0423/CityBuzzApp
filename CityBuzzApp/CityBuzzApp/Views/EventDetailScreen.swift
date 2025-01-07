import SwiftUI
import MapKit
import CoreLocation

struct EventDetailScreen: View {
    @Environment(\.presentationMode) var presentationMode
    let event: Event
    @State private var region: MKCoordinateRegion
    @StateObject private var locationManager = LocationManager()
    
    init(event: Event) {
        self.event = event
        _region = State(initialValue: MKCoordinateRegion(
            center: event.location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header with back button
                ZStack(alignment: .top) {
                    // Event banner
                    Rectangle()
                        .fill(event.categoryColor)
                        .frame(height: 200)
                        .overlay(
                            VStack {
                                Image(systemName: event.image)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 60)
                            }
                        )
                    
                    // Back button
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .imageScale(.large)
                                .padding()
                        }
                        Spacer()
                    }
                    .padding(.top, 8)
                }
                
                // Event details
                VStack(alignment: .leading, spacing: 24) {
                    // Event info
                    VStack(alignment: .leading, spacing: 8) {
                        Text(event.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        HStack(spacing: 16) {
                            Label(event.date, systemImage: "calendar")
                            Label(event.location.name, systemImage: "mappin")
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    }
                    .padding()
                    
                    // Location section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Location")
                            .font(.headline)
                        
                        Text(event.location.fullAddress)
                            .foregroundColor(.gray)
                        
                        // Map
                        Map(coordinateRegion: $region, annotationItems: [event]) { event in
                            MapMarker(coordinate: event.location.coordinate)
                        }
                        .frame(height: 200)
                        .cornerRadius(12)
                        
                        // Get Directions Button
                        Button(action: openMapsWithDirections) {
                            HStack {
                                Image(systemName: "location.fill")
                                Text("Get Directions")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .top)
        .preferredColorScheme(.dark)
        .onAppear {
            locationManager.requestLocation()
        }
    }
    
    private func openMapsWithDirections() {
        let destination = event.location.coordinate
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        mapItem.name = event.location.name
        
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}