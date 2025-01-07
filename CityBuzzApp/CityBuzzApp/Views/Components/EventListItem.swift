import SwiftUI

struct EventListItem: View {
    let event: Event
    
    // Reference the same category items as DiscoverScreen
    private let categoryItems = [
        CategoryItem(name: "Food & Drinks", 
                    icon: "fork.knife", 
                    color: Color(hex: "FF6B6B")),
        CategoryItem(name: "Music & Concerts", 
                    icon: "music.note.list", 
                    color: Color(hex: "8A2BE2")),
        CategoryItem(name: "Nightlife", 
                    icon: "moon.stars.fill", 
                    color: Color(hex: "191970")),
        CategoryItem(name: "Community", 
                    icon: "person.3.fill", 
                    color: Color(hex: "20B2AA")),
        CategoryItem(name: "Arts & Culture", 
                    icon: "paintpalette.fill", 
                    color: Color(hex: "FF4500")),
        CategoryItem(name: "Markets", 
                    icon: "leaf.fill", 
                    color: Color(hex: "32CD32")),
        CategoryItem(name: "Sports", 
                    icon: "figure.run", 
                    color: Color(hex: "1E90FF")),
        CategoryItem(name: "Comedy", 
                    icon: "face.smiling.fill", 
                    color: Color(hex: "FFD700")),
        CategoryItem(name: "Theater", 
                    icon: "theatermasks.fill", 
                    color: Color(hex: "800020")),
        CategoryItem(name: "Family Fun", 
                    icon: "figure.2.and.child", 
                    color: Color(hex: "00CED1")),
        CategoryItem(name: "Workshops", 
                    icon: "hammer.fill", 
                    color: Color(hex: "FF8C00")),
        CategoryItem(name: "Charity", 
                    icon: "hand.raised.fill", 
                    color: Color(hex: "9B2D86"))
    ]
    
    private var categoryItem: CategoryItem? {
        categoryItems.first(where: { $0.name == event.category })
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // Event Icon with custom layouts for categories
            if event.category == "Sports" {
                // Modern sports icon with running figure
                Circle()
                    .fill(Color(hex: "1E90FF"))  // Dodger blue background
                    .frame(width: 50, height: 50)
                    .overlay(
                        ZStack {
                            // White line at bottom
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 40, height: 2)
                                .offset(y: 15)
                            
                            // Running figure
                            Image(systemName: "figure.run")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .offset(y: -2)
                        }
                    )
            } else {
                // Regular category icons
                Circle()
                    .fill(categoryItem?.color ?? .blue)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: categoryItem?.icon ?? "circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    )
            }
            
            // Event Details
            VStack(alignment: .leading, spacing: 4) {
                Text(event.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(2)  // Allow up to 2 lines
                    .fixedSize(horizontal: false, vertical: true)  // Enable proper wrapping
                    .multilineTextAlignment(.leading)  // Align text to the left
                
                Text(event.location.name)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .lineLimit(1)
                
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
        .background(Color(.systemGray6).opacity(0.1))
        .cornerRadius(12)
    }
} 