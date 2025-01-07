import SwiftUI

struct HelpSupportScreen: View {
    @State private var searchQuery = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Search Bar
                TextField("Search help topics...", text: $searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Common Questions
                VStack(alignment: .leading, spacing: 20) {
                    FAQItem(
                        question: "How do I create an event?",
                        answer: "Tap the + button in the tab bar, fill in your event details, and tap Post to publish your event."
                    )
                    
                    FAQItem(
                        question: "Can I edit my event after posting?",
                        answer: "Yes, you can edit your event by going to your profile and selecting the event you want to modify."
                    )
                    
                    FAQItem(
                        question: "How do I contact support?",
                        answer: "Email us at support@citybuzz.com or use the contact form below."
                    )
                }
                
                // Contact Support
                VStack(alignment: .leading, spacing: 16) {
                    Text("Still need help?")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Button(action: {
                        // Add contact action
                    }) {
                        Text("Contact Support")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .background(Color.black)
        .foregroundColor(.white)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct FAQItem: View {
    let question: String
    let answer: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(question)
                .font(.headline)
                .foregroundColor(.blue)
            
            Text(answer)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}