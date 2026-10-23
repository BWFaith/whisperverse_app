import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whisperverse_app/screens/storypages.dart';
import 'package:whisperverse_app/stories/storymodel.dart';

class Searchbottomsheet extends StatefulWidget {
  const Searchbottomsheet({super.key, required this.books});
  final List<Book> books;

  @override
  State<Searchbottomsheet> createState() => _SearchbottomsheetState();
}

class _SearchbottomsheetState extends State<Searchbottomsheet> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Book> get _results {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return [];

    final matches = widget.books.where((b) {
      return b.title.toLowerCase().contains(q) ||
          b.author.toLowerCase().contains(q);
    }).toList();

    // Titles that START with the typed letters come first
    matches.sort((a, b) {
      final aStarts = a.title.toLowerCase().startsWith(q) ? 0 : 1;
      final bStarts = b.title.toLowerCase().startsWith(q) ? 0 : 1;
      return aStarts.compareTo(bStarts);
    });
    return matches;
  }

  void _openBook(Book book) {
    final nav = Navigator.of(context);
    nav.pop(); // close the sheet
    nav.push(
      MaterialPageRoute(
        builder: (_) => Storypages(book: book), // your detail screen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;
    return Padding(
      // keeps content above the keyboard
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              cursorColor: Colors.blueAccent,
              controller: _controller,
              autofocus: true, // keyboard opens immediately
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                hintText: 'Search by title or author',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _controller.clear();
                          setState(() => _query = '');
                        },
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: _query.trim().isEmpty
                ? const Center(child: Text('Start typing to find a book'))
                : results.isEmpty
                ? const Center(child: Text('No books found'))
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, i) {
                      final book = results[i];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CachedNetworkImage(
                            imageUrl: book.coverImage,
                            width: 40,
                            height: 56,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          book.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(book.author),
                        onTap: () => _openBook(book),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
