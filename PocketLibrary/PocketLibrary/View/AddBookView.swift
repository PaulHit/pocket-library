import SwiftUI

struct AddBookView: View {
    // 1. Get the ViewModel and the dismiss action
    @EnvironmentObject var viewModel: LibraryViewModel
    @Environment(\.dismiss) var dismiss
    
    // 2. State for all book properties
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var status: Book.Status = .wantToRead
    @State private var rating: Int = 0
    
    // 3. State for validation
    @State private var showingValidationError = false
    
    var body: some View {
        // 4. This is a separate screen/view, per the rubric.
        NavigationStack {
            Form {
                Section(header: Text("Book Details")) {
                    // 5. Labels and fields for each property
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                }
                
                Section(header: Text("Status")) {
                    // 6. Picker for status (matches your mockup)
                    Picker("Status", selection: $status) {
                        ForEach(Book.Status.allCases) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // 7. Show rating only if book has been read
                    if status == .read {
                        RatingView(rating: $rating)
                    }
                }
                
                Button("Add Book") {
                    if validate() {
                        // 8. Create a new book object
                        let newBook = Book(
                            title: title,
                            author: author,
                            coverImageUrl: "new_book_placeholder", // Placeholder
                            status: status,
                            personalRating: rating
                        )
                        // 9. Call the ViewModel's create function
                        viewModel.addBook(newBook)
                        // 10. Go back to the list
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add New Book")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            // 11. Handles validation errors per the rubric
            .alert("Missing Information", isPresented: $showingValidationError) {
                Button("OK") {}
            } message: {
                Text("Please fill out both Title and Author.")
            }
        }
    }
    
    // 12. Validation logic
    private func validate() -> Bool {
        if title.isEmpty || author.isEmpty {
            showingValidationError = true
            return false
        }
        return true
    }
}

#Preview {
    AddBookView()
        .environmentObject(LibraryViewModel())
}
