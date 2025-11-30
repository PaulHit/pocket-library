import 'package:flutter/material.dart';
import '../models/book.dart';

class LibraryProvider with ChangeNotifier {
  // Fake in-memory data
  final List<Book> _books = [
    Book(
      id: '1',
      title: 'The Midnight Library',
      author: 'Matt Haig',
      status: 'Read',
      rating: 5,
    ),
    Book(
      id: '2',
      title: 'The Vanishing Half',
      author: 'Brit Bennett',
      status: 'Currently Reading',
      rating: 0,
    ),
    Book(
      id: '3',
      title: 'Klara and the Sun',
      author: 'Kazuo Ishiguro',
      status: 'Want to Read',
      rating: 0,
    ),
  ];

  // Getter to expose the list to the UI
  List<Book> get books => _books;

  // Create Operation
  void addBook(Book book) {
    _books.add(book);
    // This tells Flutter to rebuild any widget listening to this provider
    notifyListeners();
  }

  // Update Operation
  void updateBook(Book updatedBook) {
    final index = _books.indexWhere((book) => book.id == updatedBook.id);
    if (index != -1) {
      _books[index] = updatedBook;
      notifyListeners();
    }
  }

  // Delete Operation
  void deleteBook(String bookId) {
    _books.removeWhere((book) => book.id == bookId);
    notifyListeners();
  }
}
