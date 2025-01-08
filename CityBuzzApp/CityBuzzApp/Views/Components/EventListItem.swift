import SwiftUI

struct EventListItem: View {
    let event: Event
    
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
                .frame(width: 50, height: 50)
                .overlay(
                    Group {
                        switch event.category {
                        case "Food & Drinks":
                            // Clean, modern food icon
                            Image(systemName: "fork.knife")
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                            
                        case "Music & Concerts":
                            // Modern music icon with radiating lines
                            ZStack {
                                // Radiating lines
                                ForEach(0..<48) { index in
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: 2, height: 8)
                                        .offset(y: -25)
                                        .rotationEffect(.degrees(Double(index) * 7.5))
                                }
                                
                                Image(systemName: "music.note")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            }
                            
                        case "Sports":
                            // Sports icon with line
                            ZStack {
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 40, height: 2)
                                    .offset(y: 15)
                                
                                Image(systemName: "figure.run")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                    .offset(y: -2)
                            }
                            
                        case "Comedy":
                            // Modern comedy icon with smiling face
                            Circle()
                                .fill(Color(hex: "FFD700"))  // Golden yellow background
                                .frame(width: 50, height: 50)
                                .overlay(
                                    Image(systemName: "face.smiling.fill")
                                        .font(.system(size: 28))  // Slightly larger size
                                        .foregroundStyle(
                                            Color.black.opacity(0.8)  // Semi-opaque black
                                        )
                                        .offset(y: 1)  // Slight vertical adjustment
                                )
                            
                        case "Arts & Culture":
                            // Modern paint palette icon with gradient
                            Image(systemName: "paintpalette.fill")
                                .font(.system(size: 24))
                                .foregroundStyle(
                                    .linearGradient(
                                        colors: [
                                            Color(hex: "FF0000"),  // Red
                                            Color(hex: "4169E1"),  // Royal Blue
                                            Color(hex: "FFD700"),  // Gold
                                            Color(hex: "32CD32"),  // Lime Green
                                            Color(hex: "FF1493"),  // Deep Pink
                                            Color(hex: "9370DB")   // Medium Purple
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                            
                        case "Markets":
                            // Modern markets icon with leaf
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .rotationEffect(.degrees(-45))  // Rotate leaf to match design
                            
                        case "Nightlife":
                            // Special moon and stars icon
                            Image(systemName: "moon.stars.fill")
                                .font(.system(size: 24))
                                .foregroundStyle(
                                    .linearGradient(
                                        colors: [
                                            Color(hex: "FFF4E3"),  // Warm moon glow
                                            Color(hex: "FFE5B4"),  // Peach moon
                                            Color(hex: "FFD700"),  // Golden stars
                                            Color(hex: "FFFF00")   // Bright stars
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                            
                        case "Charity":
                            // Modern charity icon with hand and heart
                            ZStack {
                                // Heart floating above hand
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .offset(y: -8)  // Position heart above hand
                                
                                // Open hand reaching up
                                Image(systemName: "hand.raised.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                    .offset(y: 4)  // Position hand slightly lower
                            }
                            
                        case "Community":
                            // Modern community icon with three people
                            Image(systemName: "person.3.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                            
                        case "Workshops":
                            // Modern workshops icon with gears
                            ZStack {
                                // Large gear in background
                                Image(systemName: "gear")
                                    .font(.system(size: 32))
                                    .foregroundColor(.white)
                                    .rotationEffect(.degrees(22.5))  // Rotate for better tooth alignment
                                
                                // Smaller gear overlapping
                                Image(systemName: "gear")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .offset(x: 8, y: 8)  // Position in bottom right
                                    .rotationEffect(.degrees(-22.5))  // Counter-rotate
                                
                                // Tools in center
                                Image(systemName: "wrench.and.screwdriver")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .offset(x: -2, y: -2)  // Position slightly up and left
                            }
                            
                        case "Family Fun":
                            // Family group icon
                            ZStack {
                                // Adult figures
                                Image(systemName: "figure.stand")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                    .offset(x: -8)
                                
                                Image(systemName: "figure.dress")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                
                                // Child figure
                                Image(systemName: "figure.child")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .offset(x: 8)
                            }
                            
                        // Add more cases for other categories...
                            
                        default:
                            Image(systemName: categoryItem?.icon ?? "circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                        }
                    }
                )
            
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