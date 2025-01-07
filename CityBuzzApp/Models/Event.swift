import SwiftUI

struct Event: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let date: String
    let location: Location
    let category: EventCategory
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }
}

enum EventCategory {
    case food, art, music, comedy
    
    func getCategoryColor() -> Color {
        switch self {
        case .food: return Color(hex: "FF7B7B")
        case .art: return Color(hex: "5151C6")
        case .music: return Color(hex: "8CD5C9")
        case .comedy: return Color(hex: "FFD426")
        }
    }
    
    func getIconName() -> String {
        switch self {
        case .food: return "mug.fill"
        case .art: return "paintpalette.fill"
        case .music: return "music.note"
        case .comedy: return "theatermasks.fill"
        }
    }
} 