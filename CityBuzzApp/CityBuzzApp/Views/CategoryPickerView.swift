import SwiftUI

struct CategoryPickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedCategory: String
    
    let categories = [
        "Food & Drinks",
        "Music & Concerts",
        "Nightlife",
        "Arts & Culture",
        "College Events",
        "Markets",
        "Sports",
        "Community"
    ]
    
    var body: some View {
        NavigationView {
            List(categories, id: \.self) { category in
                Button(action: {
                    selectedCategory = category
                    dismiss()
                }) {
                    HStack {
                        Text(category)
                        Spacer()
                        if category == selectedCategory {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("Select Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
} 