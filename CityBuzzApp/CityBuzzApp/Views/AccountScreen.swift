import SwiftUI
import PhotosUI

struct AccountScreen: View {
    @StateObject private var viewModel = AccountViewModel()
    @State private var showImagePicker = false
    @State private var showingPasswordChange = false
    @State private var showingDeleteConfirmation = false
    @State private var showingImageSourceSheet = false
    @State private var showCamera = false
    @State private var isEditing = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Profile Header
                VStack(spacing: 16) {
                    ZStack {
                        if let image = viewModel.profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(profileImageOverlay)
                                .shadow(color: .blue.opacity(0.3), radius: 10)
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
                                .shadow(color: .blue.opacity(0.3), radius: 10)
                        }
                    }
                    .onTapGesture {
                        showingImageSourceSheet = true
                    }
                    
                    VStack(spacing: 4) {
                        Text(viewModel.name.isEmpty ? "John Doe" : viewModel.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text(viewModel.username.isEmpty ? "@johndoe" : viewModel.username)
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
                    
                    ProfileField(title: "Name", text: $viewModel.name, placeholder: "John Doe", icon: "person.fill")
                        .onChange(of: viewModel.name) { viewModel.saveProfile() }
                    ProfileField(title: "Email", text: $viewModel.email, placeholder: "john.doe@example.com", icon: "envelope.fill")
                        .onChange(of: viewModel.email) { viewModel.saveProfile() }
                    ProfileField(title: "Phone", text: $viewModel.phone, placeholder: "+1 (555) 123-4567", icon: "phone.fill")
                        .onChange(of: viewModel.phone) { viewModel.saveProfile() }
                    ProfileField(title: "Location", text: $viewModel.location, placeholder: "New York, NY", icon: "location.fill")
                        .onChange(of: viewModel.location) { viewModel.saveProfile() }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bio")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        TextEditor(text: $viewModel.bio)
                            .frame(height: 100)
                            .padding(8)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .onChange(of: viewModel.bio) { viewModel.saveProfile() }
                            .overlay(
                                Group {
                                    if viewModel.bio.isEmpty {
                                        Text("Event enthusiast and community organizer")
                                            .foregroundColor(.gray)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 14)
                                    }
                                },
                                alignment: .topLeading
                            )
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray6).opacity(0.5))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.2), radius: 5)
                
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
                    .buttonStyle(.plain)
                    
                    Button {
                        showingDeleteConfirmation = true
                    } label: {
                        AccountActionButton(
                            title: "Delete Account",
                            icon: "trash.fill",
                            color: .red
                        )
                    }
                    .buttonStyle(.plain)
                }
                .padding()
                .background(Color(UIColor.systemGray6).opacity(0.5))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.2), radius: 5)
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
            ImagePicker(image: $viewModel.profileImage)
        }
        .sheet(isPresented: $showCamera) {
            CameraView(image: $viewModel.profileImage)
        }
        .confirmationDialog("Choose Image Source", isPresented: $showingImageSourceSheet) {
            Button("Take Photo") {
                showCamera = true
            }
            Button("Choose from Library") {
                showImagePicker = true
            }
            Button("Cancel", role: .cancel) {}
        }
        .alert("Change Password", isPresented: $showingPasswordChange) {
            Button("Cancel", role: .cancel) { }
            Button("Change") { viewModel.changePassword() }
        } message: {
            Text("Would you like to change your password?")
        }
        .alert("Delete Account", isPresented: $showingDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) { viewModel.deleteAccount() }
        } message: {
            Text("Are you sure you want to delete your account? This action cannot be undone.")
        }
        .navigationTitle("Account")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var profileImageOverlay: some View {
        ZStack {
            Circle()
                .stroke(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 3
                )
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "camera.fill")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .clipShape(Circle())
                        .offset(x: 6, y: 6)
                        .shadow(color: .black.opacity(0.3), radius: 3)
                }
            }
        }
    }
}

struct ProfileField: View {
    let title: String
    @Binding var text: String
    let placeholder: String
    let icon: String
    @State private var isEditing = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                TextField("", text: $text) { editing in
                    isEditing = editing
                }
                .foregroundColor(.white)
                .overlay(
                    Group {
                        if text.isEmpty {
                            Text(placeholder)
                                .foregroundColor(.gray)
                        }
                    },
                    alignment: .leading
                )
                .textContentType(textContentType)
            }
            .padding()
            .background(Color(UIColor.systemGray5))
            .cornerRadius(10)
        }
    }
    
    private var textContentType: UITextContentType? {
        switch title {
            case "Name": return .name
            case "Email": return .emailAddress
            case "Phone": return .telephoneNumber
            case "Location": return .location
            default: return nil
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
        .contentShape(Rectangle())
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
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
                provider.loadObject(ofClass: UIImage.self) { image, error in
                    if let error = error {
                        print("Error loading image: \(error)")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.parent.image = image as? UIImage
                    }
                }
            }
        }
    }
}

struct CameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

class AccountViewModel: ObservableObject {
    @Published var name = ""
    @Published var username = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var location = ""
    @Published var bio = ""
    @Published var profileImage: UIImage?
    
    func saveProfile() {
        // Save profile data to UserDefaults for now
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "profile_name")
        defaults.set(username, forKey: "profile_username") 
        defaults.set(email, forKey: "profile_email")
        defaults.set(phone, forKey: "profile_phone")
        defaults.set(location, forKey: "profile_location")
        defaults.set(bio, forKey: "profile_bio")
        
        // Save profile image to documents directory
        if let image = profileImage,
           let data = image.jpegData(compressionQuality: 0.8) {
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let imagePath = documentsPath.appendingPathComponent("profile_image.jpg")
            try? data.write(to: imagePath)
        }
    }
    
    func changePassword() {
        // In a real app, this would make an API call to change password
        // For now just print a message
        print("Password change requested")
    }
    
    func deleteAccount() {
        // In a real app, this would make an API call to delete the account
        // For now just clear local data
        let defaults = UserDefaults.standard
        let keys = ["profile_name", "profile_username", "profile_email", 
                   "profile_phone", "profile_location", "profile_bio"]
        keys.forEach { defaults.removeObject(forKey: $0) }
        
        // Delete profile image
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imagePath = documentsPath.appendingPathComponent("profile_image.jpg")
        try? FileManager.default.removeItem(at: imagePath)
        
        // Reset published properties
        name = ""
        username = ""
        email = ""
        phone = ""
        location = ""
        bio = ""
        profileImage = nil
    }
}