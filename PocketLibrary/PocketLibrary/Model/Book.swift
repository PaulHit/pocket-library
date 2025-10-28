import Foundation

// The main data model for a book.
// Conforming to Identifiable is required for using it in a SwiftUI List.
struct Book: Identifiable {
    var id = UUID() // Unique ID for the list
    var title: String
    var author: String
    var coverImageUrl: String // Will be a simple string for this demo
    var status: Status
    var personalRating: Int // 0 for unrated, 1-5 for rated

    enum Status: String, CaseIterable, Identifiable {
        case wantToRead = "Want to Read"
        case currentlyReading = "Currently Reading"
        case read = "Read"
        case didNotFinish = "Did Not Finish"
        
        var id: String { self.rawValue }
    }
}

// MARK: - Preview Data
// This is your "fake/in-memory data" source.
extension Book {
    static var previewData: [Book] = [
        Book(
            title: "The Midnight Library",
            author: "Matt Haig",
            coverImageUrl: "midnight_library", // Matches asset catalog
            status: .read,
            personalRating: 5
        ),
        Book(
            title: "The Vanishing Half",
            author: "Brit Bennett",
            coverImageUrl: "vanishing_half", // Matches asset catalog
            status: .currentlyReading,
            personalRating: 0
        ),
        Book(
            title: "Klara and the Sun",
            author: "Kazuo Ishiguro",
            coverImageUrl: "klara_and_the_sun", // Matches asset catalog
            status: .wantToRead,
            personalRating: 0
        ),
        Book(
            title: "Project Hail Mary",
            author: "Andy Weir",
            coverImageUrl: "project_hail_mary", // Matches asset catalog
            status: .read,
            personalRating: 4
        )
    ]
}
