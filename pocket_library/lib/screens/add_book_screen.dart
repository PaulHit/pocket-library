import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/library_provider.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to capture text input
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();

  String _status = 'Want to Read';
  int _rating = 0;

  void _saveBook() {
    // 1. Validate inputs
    if (_formKey.currentState!.validate()) {
      // 2. Create new book object
      final newBook = Book(
        id: DateTime.now().toString(), // Simple unique ID generation
        title: _titleController.text,
        author: _authorController.text,
        status: _status,
        rating: _status == 'Read' ? _rating : 0,
      );

      // 3. Call Provider to add
      Provider.of<LibraryProvider>(context, listen: false).addBook(newBook);

      // 4. Close screen
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Book')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: 'Author'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an author';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ['Want to Read', 'Currently Reading', 'Read']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
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
                      onPressed: () {
                        setState(() {
                          _rating = index + 1;
                        });
                      },
                    );
                  }),
                ),
              ],
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _saveBook,
                child: const Text('Save Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
