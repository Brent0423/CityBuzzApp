import SwiftUI

struct PrivacyPolicyScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Privacy Policy")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                PolicySection(
                    title: "Information We Collect",
                    content: "We collect and securely store information that you provide directly to us, including your name, email address, and location preferences. We also collect data about your event interactions to enhance your experience. All data collection is transparent and in accordance with data protection regulations."
                )
                
                PolicySection(
                    title: "How We Use Your Information",
                    content: "Your information helps us deliver a personalized experience through our platform. We use it to improve our services, customize your event recommendations, and send relevant notifications about events in your area. All processing is done with industry-standard security measures."
                )
                
                PolicySection(
                    title: "Information Sharing",
                    content: "We prioritize your privacy and never sell your personal information to third parties. Information sharing is limited to: (1) event organizers when you RSVP to their events, (2) trusted service providers who help operate our platform, and (3) cases where we're legally required to do so."
                )
                
                PolicySection(
                    title: "Your Rights & Control",
                    content: "You have full control over your personal information. Access, update, or delete your data anytime through account settings. Manage your communication preferences, opt out of promotional messages, and request data exports. We're committed to protecting your privacy rights under GDPR and other applicable regulations."
                )
                
                PolicySection(
                    title: "Data Security",
                    content: "We employ industry-leading security measures to protect your information from unauthorized access, disclosure, or misuse. This includes encryption, secure data storage, regular security audits, and strict access controls for our personnel."
                )
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 30)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color(hex: "1A1A1A")]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .foregroundColor(.white)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct PolicySection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color(hex: "3B82F6"))
            
            Text(content)
                .foregroundColor(Color.gray.opacity(0.9))
                .lineSpacing(4)
        }
        .padding()
        .background(Color(UIColor.systemGray6).opacity(0.1))
        .cornerRadius(12)
    }
}