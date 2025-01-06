import SwiftUI

// This is just to generate a temporary app icon
struct AppIconView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            Text("CB")
                .font(.system(size: 400, weight: .bold))
                .foregroundColor(.white)
        }
        .frame(width: 1024, height: 1024)
    }
} 