import SwiftUI

@main
struct PocketLibraryApp: App {
    // 1. Create the single source of truth for your data.
    // This satisfies the "fake/in-memory data" requirement.
    @StateObject private var viewModel = LibraryViewModel()

    var body: some Scene {
        WindowGroup {
            // 2. Start the app with the BookListView and pass the
            // view model into the environment for all child views to use.
            BookListView()
                .environmentObject(viewModel)
        }
    }
}
