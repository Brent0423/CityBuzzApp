import SwiftUI

struct SettingsScreen: View {
    @State private var showLogoutAlert = false
    @State private var hoveredButton: String? = nil
    @Namespace private var animation
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color(hex: "1A1A1A")]),
                    startPoint: .top,
                    endPoint: .bottom
                ).ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Account Settings Section
                        VStack(alignment: .leading, spacing: 24) {
                            Text("Account Settings")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            NavigationLink(destination: AccountScreen()) {
                                SettingsRow(title: "Account", icon: "person.circle.fill")
                            }
                            
                            NavigationLink(destination: NotificationsScreen()) {
                                SettingsRow(title: "Notifications", icon: "bell.badge.fill")
                            }
                            
                            NavigationLink(destination: PrivacyPolicyScreen()) {
                                SettingsRow(title: "Privacy", icon: "lock.shield.fill")
                            }
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6).opacity(0.5))
                        .cornerRadius(16)
                        
                        // Support Section
                        VStack(alignment: .leading, spacing: 24) {
                            Text("Support")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            NavigationLink(destination: HelpSupportScreen()) {
                                SettingsRow(title: "Help & Support", icon: "questionmark.circle.fill")
                            }
                            
                            NavigationLink(destination: AboutScreen()) {
                                SettingsRow(title: "About", icon: "info.circle.fill")
                            }
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6).opacity(0.5))
                        .cornerRadius(16)
                        
                        // Logout Section
                        VStack(alignment: .leading, spacing: 24) {
                            Button {
                                showLogoutAlert = true
                            } label: {
                                SettingsRow(
                                    title: "Log Out",
                                    icon: "rectangle.portrait.and.arrow.right.fill",
                                    color: .red
                                )
                            }
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6).opacity(0.5))
                        .cornerRadius(16)
                    }
                    .padding()
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .alert("Log Out", isPresented: $showLogoutAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Log Out", role: .destructive) {
                    // Add logout action here
                }
            } message: {
                Text("Are you sure you want to log out?")
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct SettingsRow: View {
    let title: String
    let icon: String
    var color: Color = .white
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 30)
            
            Text(title)
                .foregroundColor(color)
                .fontWeight(title == "Log Out" ? .bold : .regular)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(UIColor.systemGray5))
        .cornerRadius(10)
    }
}