import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/library_provider.dart';

class EditBookScreen extends StatefulWidget {
  final Book book;

  const EditBookScreen({super.key, required this.book});

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late String _status;
  late int _rating;

  @override
  void initState() {
    super.initState();
    // Pre-populate fields with existing data
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.author);
    _status = widget.book.status;
    _rating = widget.book.rating;
  }

  void _updateBook() {
    if (_formKey.currentState!.validate()) {
      final updatedBook = Book(
        id: widget.book.id, // Keep original ID
        title: _titleController.text,
        author: _authorController.text,
        status: _status,
        rating: _status == 'Read' ? _rating : 0,
      );

      Provider.of<LibraryProvider>(context, listen: false)
          .updateBook(updatedBook);
      Navigator.pop(context);
    }
  }

  void _deleteBook() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Book?'),
        content:
            Text('Are you sure you want to delete "${widget.book.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Delete logic
              Provider.of<LibraryProvider>(context, listen: false)
                  .deleteBook(widget.book.id);

              // Close Dialog
              Navigator.pop(ctx);
              // Close Screen (go back to list)
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Book')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (val) => val!.isEmpty ? 'Enter a title' : null,
              ),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: 'Author'),
                validator: (val) => val!.isEmpty ? 'Enter an author' : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ['Want to Read', 'Currently Reading', 'Read']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => _status = val!),
              ),
              if (_status == 'Read') ...[
                const SizedBox(height: 20),
                const Text('Your Rating'),
                Row(
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < _rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                      onPressed: () => setState(() => _rating = index + 1),
                    );
                  }),
                ),
              ],
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _updateBook,
                child: const Text('Save Changes'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: _deleteBook,
                child: const Text('Delete Book',
                    style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
