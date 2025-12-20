import SwiftUI
import SwiftData

@main
struct PocketLibraryApp: App {
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
		.modelContainer(for: Book.self)
    }
}
