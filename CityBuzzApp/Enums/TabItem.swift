import SwiftUI

enum TabItem: CaseIterable {
    case home, discover, post, settings
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .discover: return "Discover"
        case .post: return "Post"
        case .settings: return "Settings"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .discover: return "magnifyingglass"
        case .post: return "plus.circle.fill"
        case .settings: return "gearshape.fill"
        }
    }
} 