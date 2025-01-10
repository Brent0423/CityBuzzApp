import SwiftUI

struct SettingsScreen: View {
    @State private var showLogoutAlert = false
    @Binding var selectedTab: TabItem
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) { // Increased spacing
                Text("Settings")
                    .font(.system(size: 42, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, -35)
                    .foregroundColor(.white)
                
                // Rest of your settings content...
                VStack(spacing: 32) { // Increased spacing
                    // Support Section
                    SettingsSection(title: "Support") {
                        VStack(spacing: 12) { // Added spacing between navigation links
                            NavigationLink(destination: HelpSupportScreen()) {
                                SettingsRow(title: "Help & Support", icon: "questionmark.circle.fill")
                            }
                            
                            NavigationLink(destination: PrivacyPolicyScreen()) {
                                SettingsRow(title: "Privacy Policy", icon: "lock.shield.fill")
                            }
                            
                            NavigationLink(destination: AboutScreen()) {
                                SettingsRow(title: "About", icon: "info.circle.fill")
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8) // Added top padding
            }
        }
        .background(Color.black)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    withAnimation {
                        selectedTab = .home
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct SettingsSection<Content: View>: View {
    let title: String?
    let content: Content
    
    init(title: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) { // Increased spacing
            if let title = title {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
            }
            
            VStack(spacing: 4) { // Increased spacing between rows
                content
            }
            .background(Color(.systemGray6).opacity(0.1))
            .cornerRadius(12)
        }
    }
}

struct SettingsRow: View {
    let title: String
    let icon: String
    var color: Color = .white
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 22))
                .frame(width: 30)
            
            Text(title)
                .foregroundColor(color)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .padding(.vertical, 14) // Increased vertical padding
        .padding(.horizontal, 16)
    }
}