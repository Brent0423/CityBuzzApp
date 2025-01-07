import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabItem = .home
    
    var body: some View {
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
            
            SettingsScreen()
                .tag(TabItem.settings)
                .tabItem {
                    Image(systemName: TabItem.settings.icon)
                    Text(TabItem.settings.title)
                }
        }
    }
} 