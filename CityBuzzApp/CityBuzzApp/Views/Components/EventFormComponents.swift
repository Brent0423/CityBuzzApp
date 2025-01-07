import SwiftUI
import PhotosUI

struct EventInfoHeader: View {
    var body: some View {
        Text("Event Info")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.bottom, 8)
    }
}

struct DateTimeSection: View {
    @Binding var selectedDate: Date
    @Binding var selectedTime: Date
    let accentColor: Color
    
    var body: some View {
        HStack(spacing: 16) {
            // Date Picker
            VStack(alignment: .leading) {
                Text("Date")
                    .foregroundColor(.gray)
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .tint(accentColor)
            }
            .frame(maxWidth: .infinity)
            
            // Time Picker
            VStack(alignment: .leading) {
                Text("Time")
                    .foregroundColor(.gray)
                DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .tint(accentColor)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct ImageUploadSection: View {
    @Binding var selectedImage: PhotosPickerItem?
    @Binding var selectedImageData: Data?
    let accentColor: Color
    
    var body: some View {
        PhotosPicker(selection: $selectedImage, matching: .images) {
            if let selectedImageData,
               let uiImage = UIImage(data: selectedImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(accentColor, lineWidth: 2)
                    )
            } else {
                HStack {
                    Image(systemName: "photo.fill")
                        .font(.title2)
                    Text("Add Event Photo")
                        .fontWeight(.medium)
                }
                .foregroundColor(accentColor)
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .background(Color.black.opacity(0.3))
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(accentColor.opacity(0.5), lineWidth: 2)
                        .strokeStyle(.init(dash: [8]))
                )
            }
        }
    }
} 