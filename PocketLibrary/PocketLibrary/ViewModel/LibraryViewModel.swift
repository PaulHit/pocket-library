import Foundation
import Combine

// This is the "live view object" your rubric mentions.
// It holds the "fake/in-memory data" and all the logic for
// creating, reading, updating, and deleting books.
class LibraryViewModel: ObservableObject {
    
    // @Published tells SwiftUI to update any view using
    // this array whenever it changes.
    @Published var books: [Book] = []
    
    init() {
        // Load the fake data when the app starts
        books = Book.previewData
    }
    
    // MARK: - CRUD Operations
    
    // Create
    func addBook(_ book: Book) {
        books.append(book)
    }
    
    // Update
    // This finds the book by its ID and replaces it, satisfying
    // the "pass the element back" requirement.
    func updateBook(_ updatedBook: Book) {
        guard let index = books.firstIndex(where: { $0.id == updatedBook.id }) else {
            print("Error: Could not find book to update.")
            return
        }
        books[index] = updatedBook
    }
    
    // Delete
    // This finds and removes the book from the main array.
    // The @Published property wrapper automatically updates the list view.
    func deleteBook(_ book: Book) {
        books.removeAll { $0.id == book.id }
    }
}
