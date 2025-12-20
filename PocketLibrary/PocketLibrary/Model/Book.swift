import Foundation
import SwiftData

// the @Model macro automatically creates the database table
@Model
class Book {
	var id: UUID
	var title: String
	var author: String
	var coverImageUrl: String
	var statusRaw: String 		// SwiftData saves Enums best as raw strings
	var personalRating: Int
	
	// helper to interact with the Enum
	var status: Status {
		get { Status(rawValue: statusRaw) ?? .wantToRead }
		set { statusRaw = newValue.rawValue }
	}
	
	init(title: String, author: String, coverImageUrl: String, status: Status, personalRating: Int) {
		self.id = UUID()
		self.title = title
		self.author = author
		self.coverImageUrl = coverImageUrl
		self.statusRaw = status.rawValue
		self.personalRating = personalRating
	}
	
	// make the Enum codable so we can use it easily
	enum Status: String, Codable, CaseIterable, Identifiable {
		case wantToRead = "Want To Read"
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
