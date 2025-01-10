import SwiftUI

struct NavigationHeader: View {
    let dismiss: DismissAction
    let shareText: String
    
    var body: some View {
        VStack(spacing: 0) {
            // Status bar background
            Color.black
                .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top ?? 32)
            
            // Navigation bar
            HStack(spacing: 0) {
                // Back button with proper tap area
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                }
                .padding(.leading, 16)
                
                Spacer()
                
                // Share button with proper tap area
                Button(action: {
                    let av = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let window = windowScene.windows.first {
                        window.rootViewController?.present(av, animated: true)
                    }
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                }
                .padding(.trailing, 16)
            }
            .frame(height: 44)
            .background(Color.black)
        }
        .background(Color.black)
    }
}