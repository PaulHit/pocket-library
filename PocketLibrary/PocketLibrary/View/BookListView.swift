import SwiftUI

struct BookListView: View {
    // 1. Get the shared ViewModel from the environment.
    @EnvironmentObject var viewModel: LibraryViewModel
    
    // 2. State to manage the filter selection from your mockup.
    @State private var selectedStatus: Book.Status? = nil
    
    // 3. Computed property to filter the book list.
    private var filteredBooks: [Book] {
        if let selectedStatus {
            return viewModel.books.filter { $0.status == selectedStatus }
        } else {
            return viewModel.books // Show all
        }
    }

    var body: some View {
        // 4. NavigationStack is essential for navigation.
        NavigationStack {
            VStack {
                // 5. Filter Picker (from your mockup)
                FilterPicker(selectedStatus: $selectedStatus)

                // 6. The "Read" operation list.
                // This List efficiently updates only the rows that change,
                // satisfying the "no rebuild of the list/adapter" requirement.
                List(filteredBooks) { book in
                    // 7. NavigationLink to the Update/Delete screen.
                    NavigationLink(destination: BookDetailView(book: book)) {
                        BookRow(book: book)
                    }
                }
            }
            .navigationTitle("My Library")
            .toolbar {
                // 8. Toolbar button to navigate to the "Create" screen.
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

// A reusable filter button
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

// A reusable view for each row in the list
struct BookRow: View {
    let book: Book
    
    var body: some View {
        HStack(spacing: 16) {
            // Using placeholder images.
            // In a real app, you'd load this from a URL.
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

// MARK: - Preview
#Preview {
    BookListView()
        .environmentObject(LibraryViewModel())
}
