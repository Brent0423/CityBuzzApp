import SwiftUI

struct PrivacyPolicyScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Privacy Policy")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                PolicySection(
                    title: "Information We Collect",
                    content: "We collect information that you provide directly to us, including your name, email address, and location preferences. We also collect information about the events you create or interact with."
                )
                
                PolicySection(
                    title: "How We Use Your Information",
                    content: "We use the information we collect to provide and improve our services, personalize your experience, and send you relevant notifications about events in your area."
                )
                
                PolicySection(
                    title: "Information Sharing",
                    content: "We do not sell your personal information. We may share your information with event organizers when you RSVP to their events, and with service providers who assist in operating our platform."
                )
                
                PolicySection(
                    title: "Your Rights",
                    content: "You can access, update, or delete your personal information at any time through your account settings. You can also opt out of promotional communications."
                )
            }
            .padding()
        }
        .background(Color.black)
        .foregroundColor(.white)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct PolicySection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.blue)
            
            Text(content)
                .foregroundColor(.gray)
        }
    }
} 