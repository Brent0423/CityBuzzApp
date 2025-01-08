import SwiftUI

struct MainTabView: View {
    @StateObject private var eventManager = EventManager.shared
    @State private var selectedTab: TabItem = .home
    @State private var homeStack = NavigationPath()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomeScreen()
                    .navigationDestination(for: String.self) { eventId in
                        if let event = EventManager.shared.getEvent(id: eventId) {
                            EventDetailScreen(event: event)
                        }
                    }
            }
            .tag(TabItem.home)
            .tabItem {
                Image(systemName: TabItem.home.icon)
                Text(TabItem.home.title)
            }
            .onChange(of: selectedTab) { newValue in
                if newValue == .home {
                    homeStack.removeLast(homeStack.count)
                }
            }
            
            NavigationStack {
                DiscoverScreen()
                    .navigationDestination(for: String.self) { eventId in
                        if let event = EventManager.shared.getEvent(id: eventId) {
                            EventDetailScreen(event: event)
                        }
                    }
            }
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
            
            SettingsScreen()
                .tag(TabItem.settings)
                .tabItem {
                    Image(systemName: TabItem.settings.icon)
                    Text(TabItem.settings.title)
                }
        }
    }
}