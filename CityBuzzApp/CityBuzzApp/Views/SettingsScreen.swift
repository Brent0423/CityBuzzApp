import SwiftUI

struct SettingsScreen: View {
    @State private var showLogoutAlert = false
    @State private var hoveredButton: String? = nil
    @Namespace private var animation
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color(hex: "#1A1A1A")]),
                    startPoint: .top,
                    endPoint: .bottom
                ).ignoresSafeArea()
                List {
                    Section(header: Text("Account Settings")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .textCase(nil)
                        .padding(.bottom, 8)) {
                            NavigationLink(destination: AccountScreen()) {
                                Label("Account", systemImage: "person.circle.fill")
                                    .foregroundColor(.white)
                                    .contentTransition(.opacity)
                            }
                            .listRowSeparator(.hidden)
                            .buttonStyle(HoverButtonStyle())
                            
                            NavigationLink(destination: NotificationsScreen()) {
                                Label("Notifications", systemImage: "bell.badge.fill")
                                    .foregroundColor(.white)
                                    .contentTransition(.opacity)
                            }
                            .listRowSeparator(.hidden)
                            .buttonStyle(HoverButtonStyle())
                            
                            NavigationLink(destination: PrivacyPolicyScreen()) {
                                Label("Privacy", systemImage: "lock.shield.fill")
                                    .foregroundColor(.white)
                                    .contentTransition(.opacity)
                            }
                            .buttonStyle(HoverButtonStyle())
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(UIColor.systemGray6).opacity(0.95))
                    )
                    .padding(.vertical, 8)
                    
                    Section(header: Text("Support")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .textCase(nil)
                        .padding(.bottom, 8)) {
                            NavigationLink(destination: HelpSupportScreen()) {
                                Label("Help & Support", systemImage: "questionmark.circle.fill")
                                    .foregroundColor(.white)
                                    .contentTransition(.opacity)
                            }
                            .listRowSeparator(.hidden)
                            .buttonStyle(HoverButtonStyle())
                            
                            NavigationLink(destination: AboutScreen()) {
                                Label("About", systemImage: "info.circle.fill")
                                    .foregroundColor(.white)
                                    .contentTransition(.opacity)
                            }
                            .buttonStyle(HoverButtonStyle())
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(UIColor.systemGray6).opacity(0.95))
                    )
                    .padding(.vertical, 8)
                    
                    Section {
                        Button {
                            showLogoutAlert = true
                        } label: {
                            Label("Log Out", systemImage: "rectangle.portrait.and.arrow.right.fill")
                                .foregroundColor(Color(red: 0.8, green: 0.2, blue: 0.2))
                                .contentTransition(.opacity)
                        }
                        .alert("Log Out", isPresented: $showLogoutAlert) {
                            Button("Cancel", role: .cancel) { }
                            Button("Log Out", role: .destructive) {
                                // Add logout action here
                            }
                        } message: {
                            Text("Are you sure you want to log out?")
                        }
                        .buttonStyle(HoverButtonStyle())
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(UIColor.systemGray6).opacity(0.95))
                    )
                }
                .listStyle(InsetGroupedListStyle())
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(.stack)
    }
}

struct HoverButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
} 