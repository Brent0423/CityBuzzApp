import SwiftUI
import PhotosUI

struct AccountScreen: View {
    @State private var name = "John Doe"
    @State private var username = "@johndoe"
    @State private var email = "john.doe@example.com"
    @State private var phone = "+1 (555) 123-4567"
    @State private var location = "New York, NY"
    @State private var bio = "Event enthusiast and community organizer"
    @State private var showImagePicker = false
    @State private var profileImage: UIImage?
    @State private var showingPasswordChange = false
    @State private var showingDeleteConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Profile Header
                VStack(spacing: 16) {
                    ZStack {
                        if let image = profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(profileImageOverlay)
                        } else {
                            Circle()
                                .fill(Color(UIColor.systemGray4))
                                .frame(width: 120, height: 120)
                                .overlay(
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.white)
                                        .padding(24)
                                )
                                .overlay(profileImageOverlay)
                        }
                    }
                    .onTapGesture {
                        showImagePicker = true
                    }
                    
                    VStack(spacing: 4) {
                        Text(name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text(username)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical)
                
                // Profile Info Section
                VStack(alignment: .leading, spacing: 24) {
                    Text("Profile Information")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    ProfileField(title: "Name", text: $name, icon: "person.fill")
                    ProfileField(title: "Email", text: $email, icon: "envelope.fill")
                    ProfileField(title: "Phone", text: $phone, icon: "phone.fill")
                    ProfileField(title: "Location", text: $location, icon: "location.fill")
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bio")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        TextEditor(text: $bio)
                            .frame(height: 100)
                            .padding(8)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray6).opacity(0.5))
                .cornerRadius(16)
                
                // Account Actions
                VStack(alignment: .leading, spacing: 24) {
                    Text("Account Settings")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    Button {
                        showingPasswordChange = true
                    } label: {
                        AccountActionButton(
                            title: "Change Password",
                            icon: "lock.fill",
                            color: .blue
                        )
                    }
                    
                    Button {
                        showingDeleteConfirmation = true
                    } label: {
                        AccountActionButton(
                            title: "Delete Account",
                            icon: "trash.fill",
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
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color(hex: "1A1A1A")]),
                startPoint: .top,
                endPoint: .bottom
            ).ignoresSafeArea()
        )
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $profileImage)
        }
        .alert("Change Password", isPresented: $showingPasswordChange) {
            Button("Cancel", role: .cancel) { }
            Button("Change") { }
        } message: {
            Text("Would you like to change your password?")
        }
        .alert("Delete Account", isPresented: $showingDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) { }
        } message: {
            Text("Are you sure you want to delete your account? This action cannot be undone.")
        }
        .navigationTitle("Account")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var profileImageOverlay: some View {
        ZStack {
            Circle()
                .stroke(Color.blue, lineWidth: 3)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "camera.fill")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .offset(x: 6, y: 6)
                }
            }
        }
    }
}

struct ProfileField: View {
    let title: String
    @Binding var text: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                TextField(title, text: $text)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color(UIColor.systemGray5))
            .cornerRadius(10)
        }
    }
}

struct AccountActionButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(title)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .opacity(0.5)
        }
        .foregroundColor(color)
        .padding()
        .background(Color(UIColor.systemGray5))
        .cornerRadius(10)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.presentationMode.wrappedValue.dismiss()
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        self.parent.image = image as? UIImage
                    }
                }
            }
        }
    }
} 