import SwiftUI
import SwiftData

struct AddBookView: View {
	// get the DB context
	@Environment(\.modelContext) private var context
	@Environment(\.dismiss) var dismiss
	
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var status: Book.Status = .wantToRead
    @State private var rating: Int = 0
    
    @State private var showingValidationError = false
    
    var body: some View {
        NavigationStack {
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
                
                Button("Add Book") {
                    if validate() {
                        let newBook = Book(
                            title: title,
                            author: author,
                            coverImageUrl: "new_book_placeholder",
                            status: status,
							personalRating: status == .read ? rating : 0
                        )
						context.insert(newBook)
						
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
            .alert("Missing Information", isPresented: $showingValidationError) {
                Button("OK") {}
            } message: {
                Text("Please fill out both Title and Author.")
            }
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
