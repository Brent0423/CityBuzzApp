import SwiftUI

struct EventCard: View {
    let event: Event
    
    var body: some View {
        HStack(spacing: 16) {
            // Left side - Icon with category color
            Circle()
                .fill(event.category.getCategoryColor())
                .frame(width: 44, height: 44)
                .overlay(
                    Image(systemName: event.image)
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