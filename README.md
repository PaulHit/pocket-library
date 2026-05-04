✦ Pocket Library 📚

  Pocket Library is a dual-implementation mobile application (Native & Non-Native) designed for book enthusiasts to
  track their personal reading journeys. It serves as a digital librarian, allowing users to catalog books they own, are
  currently reading, or wish to read in the future.

  This project was developed as part of the Mobile Applications course at UBB Cluj-Napoca.

  ---

  🚀 Key Features

   - Personal Digital Catalog: Maintain a comprehensive list of your books.
   - Reading Status Tracking: Categorize books as Want to Read, Currently Reading, Read, or Did Not Finish.
   - Personal Ratings: Rate your books on a scale of 1 to 5 stars.
   - Full CRUD Support: Create, Read, Update, and Delete book entries.
   - Offline Capability: View and manage your library even without an internet connection.

  ---

  🏗 Project Structure

  The repository is divided into two main implementations to demonstrate different mobile development paradigms:

  1. Native Implementation (PocketLibrary/)
   - Technology Stack: Swift, SwiftUI, SwiftData.
   - Persistence: Utilizes Apple's SwiftData framework for seamless local database management and modern data modeling.
   - UI/UX: Follows Apple's Human Interface Guidelines for a native iOS/macOS feel.

  2. Non-Native Implementation (pocket_library/)
   - Technology Stack: Dart, Flutter.
   - State Management: Uses the Provider pattern for efficient data flow and UI updates.
   - Cross-Platform: Designed to run on Android, iOS, Web, and Desktop from a single codebase.

  ---

  📖 Domain Model: Book

  The core entity across both projects includes:
   - ID: Unique identifier (ISBN or UUID).
   - Title: The official title of the book.
   - Author: The author's name.
   - Status: Current progress (e.g., "Currently Reading").
   - Rating: User-assigned score (1-5).
   - Cover Image: Visual representation of the book.

  ---

  🛠 Getting Started

  Prerequisites
   - For Native: Xcode 15+ (for SwiftData support).
   - For Flutter: Flutter SDK and Android Studio/VS Code.

  Running the Native App
   1. Navigate to the PocketLibrary directory.
   2. Open PocketLibrary.xcodeproj in Xcode.
   3. Select a simulator or physical device and press Cmd + R.

  Running the Flutter App
   1. Navigate to the pocket_library directory.
   2. Run flutter pub get to install dependencies.
   3. Run flutter run to launch the application on your connected device or simulator.

  ---

  🖼 App Mockups
  The conceptual design and initial ideas can be found in the idea/ directory, which includes screenshots of the
  intended list and add/edit screens.

  ---

  This project was created for educational purposes to explore mobile application architecture and persistence
  strategies.
