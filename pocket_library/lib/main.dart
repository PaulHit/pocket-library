import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/library_provider.dart';
import 'screens/book_list_screen.dart';

void main() {
  runApp(
    // We wrap the entire app in the Provider
    ChangeNotifierProvider(
      create: (context) => LibraryProvider(),
      child: const PocketLibraryApp(),
    ),
  );
}

class PocketLibraryApp extends StatelessWidget {
  const PocketLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket Library',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const BookListScreen(),
    );
  }
}
