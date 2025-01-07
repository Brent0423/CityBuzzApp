import SwiftUI

struct EventListItem: View {
    let event: Event
    
    func getIconColor(for category: String) -> Color {
        switch category {
        case "Food & Drinks":
            return Color(hex: "FF7B7B") // Red
        case "Arts & Culture":
            return Color(hex: "5151C6") // Purple
        case "Music & Concerts":
            return Color(hex: "8CD5C9") // Teal
        case "Nightlife":
            return Color(hex: "FFD426") // Yellow
        case "Sports":
            return Color.blue
        default:
            return .blue
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // Event Icon
            Circle()
                .fill(getIconColor(for: event.category))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: event.image)
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                )
            
            // Event Details
            VStack(alignment: .leading, spacing: 4) {
                Text(event.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                
                Text(event.location.shortDisplay)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                
                Text(event.date)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(size: 16))
        }
        .padding()
        .background(Color(UIColor.systemGray6).opacity(0.1))
        .cornerRadius(12)
    }
} 