import SwiftUI

extension String {
    func getCategoryColor() -> Color {
        switch self {
        case "Food & Drinks":
            return Color(hex: "FF6B6B")
        case "Music & Concerts":
            return Color(hex: "A8E6CF")
        case "Nightlife":
            return Color(hex: "FFD93D")
        case "Community":
            return Color(hex: "4ECDC4")
        case "Arts & Culture":
            return Color(hex: "3B4371")
        case "Markets":
            return Color(hex: "FF6B6B")
        case "Sports":
            return Color(hex: "A8E6CF")
        case "College Events":
            return Color(hex: "FFD93D")
        default:
            return Color.blue
        }
    }
} 