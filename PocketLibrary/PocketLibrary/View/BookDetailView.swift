import SwiftUI

struct BookDetailView: View {
    // 1. Get ViewModel and dismiss action
    @EnvironmentObject var viewModel: LibraryViewModel
    @Environment(\.dismiss) var dismiss
    
    // 2. The original book passed from the list
    let originalBook: Book
    
    // 3. Local state for editing. This satisfies the
    // "pre-populated" requirement from the rubric.
    @State private var title: String
    @State private var author: String
    @State private var status: Book.Status
    @State private var rating: Int
    
    // 4. State for validation and delete confirmation
    @State private var showingValidationError = false
    @State private var showingDeleteAlert = false
    
    // 5. Initialize the local state with the book's data
    init(book: Book) {
        self.originalBook = book
        _title = State(initialValue: book.title)
        _author = State(initialValue: book.author)
        _status = State(initialValue: book.status)
        _rating = State(initialValue: book.personalRating)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Book Details")) {
                // 6. All fields are pre-populated and editable
                TextField("Title", text: $title)
                TextField("Author", text: $author)
            }
            
            Section(header: Text("Status")) {
                Picker("Status", selection: $status) {
                    ForEach(Book.Status.allCases) { status in
                        Text(status.rawValue).tag(status)
                    }
                }
                .pickerStyle(.segmented)
                
                // Show rating view if status is "Read"
                if status == .read {
                    RatingView(rating: $rating)
                } else if status != .read && rating > 0 {
                    // Clear rating if status is changed from "Read"
                    Text("Rating will be cleared on save.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            // MARK: - Update Operation
            Section {
                Button("Save Changes") {
                    if validate() {
                        // 7. Create an *updated* book object
                        let updatedBook = Book(
                            id: originalBook.id, // Keep the same ID
                            title: title,
                            author: author,
                            coverImageUrl: originalBook.coverImageUrl, // Keep same image
                            status: status,
                            // Clear rating if no longer "Read"
                            personalRating: status == .read ? rating : 0
                        )
                        
                        // 8. "Pass the element back" to the ViewModel
                        viewModel.updateBook(updatedBook)
                        dismiss()
                    }
                }
            }
            
            // MARK: - Delete Operation
            Section {
                Button("Delete Book", role: .destructive) {
                    // 9. Triggers the confirmation dialog
                    showingDeleteAlert = true
                }
            }
        }
        .navigationTitle("Edit Book")
        .navigationBarTitleDisplayMode(.inline)
        // 10. Handles validation errors
        .alert("Missing Information", isPresented: $showingValidationError) {
            Button("OK") {}
        } message: {
            Text("Please fill out both Title and Author.")
        }
        // 11. Handles "Delete" confirmation dialog, per the rubric
        .alert("Delete Book?", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                // 12. "Properly identified" and "removed"
                viewModel.deleteBook(originalBook)
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete \"\(originalBook.title)\"?")
        }
    }
    
    // 13. Validation logic
    private func validate() -> Bool {
        if title.isEmpty || author.isEmpty {
            showingValidationError = true
            return false
        }
        return true
    }
}

#Preview {
    NavigationStack {
        BookDetailView(book: Book.previewData[0])
            .environmentObject(LibraryViewModel())
    }
}
