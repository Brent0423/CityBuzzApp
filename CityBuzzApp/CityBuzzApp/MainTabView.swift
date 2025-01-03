import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabItem = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeScreen()
                .tag(TabItem.home)
                .tabItem {
                    VStack {
                        Image(systemName: TabItem.home.icon)
                        Text(TabItem.home.title)
                    }
                }
            
            DiscoverScreen()
                .tag(TabItem.discover)
                .tabItem {
                    VStack {
                        Image(systemName: TabItem.discover.icon)
                        Text(TabItem.discover.title)
                    }
                }
            
            Text("Post Screen")
                .tag(TabItem.post)
                .tabItem {
                    VStack {
                        Image(systemName: TabItem.post.icon)
                        Text(TabItem.post.title)
                    }
                }
            
            Text("Settings Screen")
                .tag(TabItem.settings)
                .tabItem {
                    VStack {
                        Image(systemName: TabItem.settings.icon)
                        Text(TabItem.settings.title)
                    }
                }
        }
        .accentColor(.blue)
        .preferredColorScheme(.dark)
    }
} 