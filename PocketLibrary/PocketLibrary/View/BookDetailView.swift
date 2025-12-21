import SwiftUI
import SwiftData

struct BookDetailView: View {
	@Environment(\.modelContext) private var context
	@Environment(\.dismiss) var dismiss
    
    let book: Book
    
    @State private var title: String
    @State private var author: String
    @State private var status: Book.Status
    @State private var rating: Int
    
    @State private var showingValidationError = false
    @State private var showingDeleteAlert = false
    
    init(book: Book) {
        self.book = book
        _title = State(initialValue: book.title)
        _author = State(initialValue: book.author)
        _status = State(initialValue: book.status)
        _rating = State(initialValue: book.personalRating)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Book Details")) {
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
                
                if status == .read {
                    RatingView(rating: $rating)
                }
            }
            
            // MARK: - Update Operation
            Section {
                Button("Save Changes") {
                    if validate() {
						book.title = title
						book.author = author
						book.status = status
						book.personalRating = status == .read ? rating : 0
						
                        dismiss()
                    }
                }
            }

            Section {
                Button("Delete Book", role: .destructive) {
                    showingDeleteAlert = true
                }
            }
        }
        .navigationTitle("Edit Book")
        .alert("Missing Information", isPresented: $showingValidationError) {
            Button("OK") {}
        } message: {
            Text("Please fill out both Title and Author.")
        }
        .alert("Delete Book?", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
				context.delete(book)
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete \"\(book.title)\"?")
        }
    }
    
    private func validate() -> Bool {
        if title.isEmpty || author.isEmpty {
            showingValidationError = true
            return false
        }
        return true
    }
}
