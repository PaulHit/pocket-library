import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/library_provider.dart';
import 'add_book_screen.dart';
import 'edit_book_screen.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Library'),
      ),
      // FAB to navigate to the Create Screen
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBookScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      // Consumer listens to the provider. It only rebuilds this part when data changes.
      body: Consumer<LibraryProvider>(
        builder: (context, libraryProvider, child) {
          return ListView.builder(
            itemCount: libraryProvider.books.length,
            itemBuilder: (context, index) {
              final book = libraryProvider.books[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 75,
                    color: Colors.grey[300],
                    child: const Icon(Icons.book, color: Colors.grey),
                  ),
                  title: Text(
                    book.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${book.author}\n${book.status}'),
                  isThreeLine: true,
                  onTap: () {
                    // Navigate to Update Screen, passing the book object
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditBookScreen(book: book),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
