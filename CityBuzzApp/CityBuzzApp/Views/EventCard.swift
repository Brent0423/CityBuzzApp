import SwiftUI

struct EventCard: View {
    let event: Event
    @Binding var homeStack: NavigationPath
    
    var body: some View {
        NavigationLink(destination: EventDetailScreen(
            homeStack: $homeStack,
            event: event
        )) {
            HStack(spacing: 16) {
                // Left side - Icon with category color
                Circle()
                    .fill(event.category.getCategoryColor())
                    .frame(width: 44, height: 44)
                    .overlay(
                        Image(systemName: "calendar.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                    )
                
                // Event Details
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.name)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text(event.date)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        Image(systemName: "mappin")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        Text(event.location.name)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color.black)
            .cornerRadius(12)
        }
    }
}

#Preview {
    EventCard(
        event: Event(
            name: "Sample Event",
            date: "1/16 @ 7 PM",
            location: Location(
                name: "Sample Location",
                area: "Downtown",
                city: "Kalamazoo",
                fullAddress: "123 Main St, Kalamazoo, MI 49007",
                latitude: 42.2917,
                longitude: -85.5872
            ),
            category: "Food & Drinks"
        ),
        homeStack: .constant(NavigationPath())
    )
}