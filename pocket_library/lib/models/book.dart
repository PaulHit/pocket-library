class Book {
  final String id;
  final String title;
  final String author;
  final String status; // "Want to Read", "Currently Reading", "Read"
  final int rating; // 0-5

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.status,
    required this.rating,
  });

  // Helper to create a copy of a book with some updated fields
  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? status,
    int? rating,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      status: status ?? this.status,
      rating: rating ?? this.rating,
    );
  }
}
