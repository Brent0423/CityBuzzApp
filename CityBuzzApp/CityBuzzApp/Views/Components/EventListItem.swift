import SwiftUI

struct EventListItem: View {
    let event: Event
    @Binding var homeStack: NavigationPath
    
    // Reference the same category items as DiscoverScreen
    private let categoryItems = [
        CategoryItem(name: "Food & Drinks", 
                    icon: "fork.knife", 
                    color: Color(hex: "FF8C00")),
        CategoryItem(name: "Music & Concerts", 
                    icon: "music.note.list", 
                    color: Color(hex: "8A2BE2")),
        CategoryItem(name: "Nightlife", 
                    icon: "moon.stars.fill", 
                    color: Color.black),  // Changed from "191970" (Midnight blue) to black
        CategoryItem(name: "Community", 
                    icon: "person.3.fill", 
                    color: Color(hex: "20B2AA")),
        CategoryItem(name: "Arts & Culture", 
                    icon: "paintpalette.fill", 
                    color: Color(hex: "FF4500")),
        CategoryItem(name: "Markets", 
                    icon: "leaf.fill", 
                    color: Color(hex: "2E8B57")),
        CategoryItem(name: "Sports", 
                    icon: "figure.run", 
                    color: Color(hex: "4169E1")),
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
                    color: Color(hex: "D2691E")),
        CategoryItem(name: "Charity", 
                    icon: "hand.raised.fill", 
                    color: Color(hex: "9B2D86"))
    ]
    
    private var categoryItem: CategoryItem? {
        categoryItems.first(where: { $0.name == event.category })
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // Event Icon with custom layouts for all categories
            Circle()
                .fill(categoryItem?.color ?? .blue)
                .frame(width: 40, height: 40)
                .overlay(
                    Group {
                        switch event.category {
                        case "Food & Drinks":
                            // Clean, modern food icon
                            Image(systemName: "fork.knife")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                            
                        case "Music & Concerts":
                            // Modern music icon with radiating lines
                            ZStack {
                                // Radiating lines
                                ForEach(0..<48) { index in
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: 1.5, height: 6)
                                        .offset(y: -20)
                                        .rotationEffect(.degrees(Double(index) * 7.5))
                                }
                                
                                Image(systemName: "music.note")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            }
                            
                        case "Sports":
                            // Sports icon with line
                            ZStack {
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 32, height: 1.5)
                                    .offset(y: 12)
                                
                                Image(systemName: "figure.run")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .offset(y: -2)
                            }
                            
                        case "Comedy":
                            // Modern comedy icon with smiling face
                            Circle()
                                .fill(Color(hex: "FFD700"))  // Golden yellow background
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Image(systemName: "face.smiling.fill")
                                        .font(.system(size: 24))
                                        .foregroundStyle(
                                            Color.black.opacity(0.8)
                                        )
                                        .offset(y: 1)
                                )
                            
                        case "Arts & Culture":
                            // Modern paint palette icon with gradient
                            Image(systemName: "paintpalette.fill")
                                .font(.system(size: 20))
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
                            // Modern markets icon with leaf
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .rotationEffect(.degrees(-45))
                            
                        case "Nightlife":
                            // Special moon and stars icon
                            Image(systemName: "moon.stars.fill")
                                .font(.system(size: 20))
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
                            // Modern charity icon with hand and heart
                            ZStack {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .offset(y: -6)
                                
                                Image(systemName: "hand.raised.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .offset(y: 3)
                            }
                            
                        case "Community":
                            // Modern community icon with three people
                            Image(systemName: "person.3.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                            
                        case "Workshops":
                            // Modern workshops icon with gears
                            ZStack {
                                Image(systemName: "gear")
                                    .font(.system(size: 26))
                                    .foregroundColor(.white)
                                    .rotationEffect(.degrees(22.5))
                                
                                Image(systemName: "gear")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .offset(x: 6, y: 6)
                                    .rotationEffect(.degrees(-22.5))
                                
                                Image(systemName: "wrench.and.screwdriver")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .offset(x: -2, y: -2)
                            }
                            
                        case "Family Fun":
                            // Family group icon
                            ZStack {
                                Image(systemName: "figure.stand")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .offset(x: -6)
                                
                                Image(systemName: "figure.dress")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                
                                Image(systemName: "figure.child")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .offset(x: 6)
                            }
                            
                        default:
                            Image(systemName: categoryItem?.icon ?? "circle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                    }
                )
            
            // Event Details
            VStack(alignment: .leading, spacing: 4) {
                Text(event.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(event.location.fullAddress)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(event.date)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .padding(.trailing, 4) // Add padding to prevent chevron from being cut off
        }
        .padding()
        .background(Color(.systemGray6).opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    EventListItem(
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