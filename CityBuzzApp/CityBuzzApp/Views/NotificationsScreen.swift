import SwiftUI

struct NotificationsScreen: View {
    @State private var pushEnabled = true
    @State private var emailEnabled = true
    @State private var eventReminders = true
    @State private var newEvents = true
    @State private var communityUpdates = true
    @State private var specialOffers = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Main Notification Toggles
                VStack(alignment: .leading, spacing: 24) {
                    Text("Notification Settings")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    NotificationToggle(
                        title: "Push Notifications",
                        subtitle: "Receive notifications on your device",
                        isOn: $pushEnabled,
                        icon: "bell.badge.fill"
                    )
                    
                    NotificationToggle(
                        title: "Email Notifications", 
                        subtitle: "Receive notifications via email",
                        isOn: $emailEnabled,
                        icon: "envelope.fill"
                    )
                }
                .padding()
                .background(Color(UIColor.systemGray6).opacity(0.5))
                .cornerRadius(16)
                
                // Notification Types
                VStack(alignment: .leading, spacing: 24) {
                    Text("Notification Types")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    NotificationToggle(
                        title: "Event Reminders",
                        subtitle: "Get reminded about upcoming events",
                        isOn: $eventReminders,
                        icon: "calendar.badge.clock"
                    )
                    
                    NotificationToggle(
                        title: "New Events",
                        subtitle: "Be notified when new events are added",
                        isOn: $newEvents,
                        icon: "sparkles"
                    )
                    
                    NotificationToggle(
                        title: "Community Updates",
                        subtitle: "Stay updated with community news",
                        isOn: $communityUpdates,
                        icon: "person.3.fill"
                    )
                    
                    NotificationToggle(
                        title: "Special Offers",
                        subtitle: "Receive special deals and promotions",
                        isOn: $specialOffers,
                        icon: "tag.fill"
                    )
                }
                .padding()
                .background(Color(UIColor.systemGray6).opacity(0.5))
                .cornerRadius(16)
            }
            .padding()
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color(hex: "1A1A1A")]),
                startPoint: .top,
                endPoint: .bottom
            ).ignoresSafeArea()
        )
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct NotificationToggle: View {
    let title: String
    let subtitle: String
    @Binding var isOn: Bool
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.body)
                Text(subtitle)
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(.blue)
        }
        .padding()
        .background(Color(UIColor.systemGray5))
        .cornerRadius(10)
    }
}

#Preview {
    NavigationView {
        NotificationsScreen()
    }
    .preferredColorScheme(.dark)
}