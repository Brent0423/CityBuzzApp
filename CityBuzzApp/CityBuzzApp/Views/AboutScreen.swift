import SwiftUI

struct AboutScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                Text("About City Buzz")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(.linearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                    .padding(.bottom, 8)
                
                VStack(alignment: .leading, spacing: 24) {
                    InfoSection(
                        title: "What is City Buzz?",
                        content: "City Buzz is your ultimate companion for discovering and creating unforgettable local experiences. We curate and showcase the best events happening in your community - from underground music shows and pop-up art galleries to food festivals and cultural celebrations. Our smart recommendations help you discover hidden gems while our social features let you share and connect with fellow event enthusiasts.",
                        icon: "sparkles.rectangle.stack.fill"
                    )
                    
                    InfoSection(
                        title: "Our Mission",
                        content: "We're on a mission to transform how people experience their cities. By breaking down barriers between event organizers and attendees, we're building vibrant local communities where everyone can find their perfect event. Our platform empowers creators while helping attendees discover authentic local experiences they'll love.",
                        icon: "flag.fill"
                    )
                    
                    InfoSection(
                        title: "Get Involved",
                        content: "Join our growing community of event creators and enthusiasts. Whether you're organizing a small meetup or a major festival, City Buzz gives you the tools to reach your audience. Follow us on social media and sign up for our newsletter to stay updated on the latest features and community highlights.",
                        icon: "person.3.fill"
                    )
                    
                    InfoSection(
                        title: "Version",
                        content: "1.0.0 (Build 2024.1)",
                        icon: "info.circle.fill"
                    )
                }
            }
            .padding(24)
        }
        .background(
            LinearGradient(
                colors: [.black, Color(hex: "1A1A1A")],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .foregroundColor(.white)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct InfoSection: View {
    let title: String
    let content: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(.linearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            Text(content)
                .font(.body)
                .foregroundColor(.gray)
                .lineSpacing(4)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
}