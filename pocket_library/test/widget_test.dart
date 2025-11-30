import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

// We use 'pocket_library' because that is the package name in your current file.
import 'package:pocket_library/main.dart';
import 'package:pocket_library/providers/library_provider.dart';

void main() {
  testWidgets('App loads and shows library title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // We must wrap the app in the Provider, just like in main.dart,
    // otherwise the Consumer in BookListScreen will throw an error.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => LibraryProvider(),
        child: const PocketLibraryApp(),
      ),
    );

    // Verify that the app starts on the 'My Library' screen
    expect(find.text('My Library'), findsOneWidget);

    // Check that we have a FloatingActionButton (the + button)
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
