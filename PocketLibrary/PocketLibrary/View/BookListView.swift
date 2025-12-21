import SwiftUI
import SwiftData

struct BookListView: View {
	// @Query automatically fetches books from the DB and watches for changes
	@Query(sort: \Book.title) private var books: [Book]
	
	// we need the 'Context' to delete things
	@Environment(\.modelContext) private var context
	
	@State private var selectedStatus: Book.Status? = nil
	
	private var filteredBooks: [Book] {
        if let selectedStatus {
            return books.filter { $0.status == selectedStatus }
        } else {
            return books
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                FilterPicker(selectedStatus: $selectedStatus)

				List {
					ForEach(filteredBooks) {
						book in
						NavigationLink(destination: BookDetailView(book: book)) {
							BookRow(book: book)
						}
					}
				}
            }
            .navigationTitle("My Library")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddBookView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

// MARK: - Subviews

// A reusable view for the filter buttons
struct FilterPicker: View {
    @Binding var selectedStatus: Book.Status?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                // "All" Button
                FilterButton(
                    title: "All",
                    isSelected: selectedStatus == nil,
                    action: { selectedStatus = nil }
                )
                
                // Buttons for each status
                ForEach(Book.Status.allCases) { status in
                    FilterButton(
                        title: status.rawValue,
                        isSelected: selectedStatus == status,
                        action: { selectedStatus = status }
                    )
                }
            }
            .padding(.horizontal)
        }
        .padding(.top, 8)
    }
}

struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(16)
        }
    }
}

struct BookRow: View {
    let book: Book
    
    var body: some View {
        HStack(spacing: 16) {
            Image(book.coverImageUrl)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 75)
                .cornerRadius(4)
                .shadow(radius: 2)

            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

