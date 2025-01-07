import SwiftUI

struct TrendingEventCard: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Hero Image
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .fill(LinearGradient(
                        colors: [.blue.opacity(0.7), .purple.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(height: 160)
                
                // Event Details Overlay
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    HStack(spacing: 8) {
                        // Date
                        HStack(spacing: 4) {
                            Image(systemName: "calendar")
                            Text(event.date)
                        }
                        
                        // Location
                        HStack(spacing: 4) {
                            Image(systemName: "mappin")
                            Text(event.location.name)
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                }
                .padding()
                .background(
                    LinearGradient(
                        colors: [.black.opacity(0.7), .clear],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
            }
        }
        .cornerRadius(16)
        .padding(.horizontal)
    }
}