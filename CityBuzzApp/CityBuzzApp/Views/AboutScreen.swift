import SwiftUI

struct AboutScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("About City Buzz")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 16) {
                    InfoSection(title: "What is City Buzz?", content: "City Buzz is your go-to platform for discovering and sharing local events in your community. Whether you're looking for concerts, art shows, food festivals, or community gatherings, City Buzz helps you stay connected to what's happening around you.")
                    
                    InfoSection(title: "Our Mission", content: "To create a vibrant, connected community by making local events more accessible and discoverable for everyone.")
                    
                    InfoSection(title: "Version", content: "1.0.0")
                }
            }
            .padding()
        }
        .background(Color.black)
        .foregroundColor(.white)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct InfoSection: View {
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