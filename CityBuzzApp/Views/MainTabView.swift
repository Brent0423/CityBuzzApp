import SwiftUI

struct MainTabView: View {
    init() {
        // Configure tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        
        // Remove any default borders or separators
        appearance.shadowColor = .clear
        appearance.shadowImage = nil
        
        // Configure tab bar item appearance
        let itemAppearance = UITabBarItemAppearance()
        
        // Remove all background effects
        appearance.backgroundEffect = nil
        appearance.backgroundColor = .black
        
        // Normal state (unselected)
        itemAppearance.normal.iconColor = .gray
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        
        // Selected state
        itemAppearance.selected.iconColor = .blue
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.blue]
        
        // Apply to all layout appearances
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        
        // Apply to both standard and scrolled states
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().unselectedItemTintColor = .gray
        UITabBar.appearance().barTintColor = .black
        
        // Remove default border and make background fully black
        UITabBar.appearance().clipsToBounds = true
        UITabBar.appearance().backgroundColor = .black
    }
    
    @State private var selectedTab: TabItem = .home
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            TabView(selection: $selectedTab) {
                HomeScreen()
                    .tag(TabItem.home)
                    .tabItem {
                        Image(systemName: TabItem.home.icon)
                        Text(TabItem.home.title)
                    }
                
                DiscoverScreen()
                    .tag(TabItem.discover)
                    .tabItem {
                        Image(systemName: TabItem.discover.icon)
                        Text(TabItem.discover.title)
                    }
                
                PostEventScreen()
                    .tag(TabItem.post)
                    .tabItem {
                        Image(systemName: TabItem.post.icon)
                        Text(TabItem.post.title)
                    }
                
                Text("Settings")
                    .tag(TabItem.settings)
                    .tabItem {
                        Image(systemName: TabItem.settings.icon)
                        Text(TabItem.settings.title)
                    }
            }
        }
        .preferredColorScheme(.dark)
    }
} 