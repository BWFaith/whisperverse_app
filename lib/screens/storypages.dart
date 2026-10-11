import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/firebase_repository/bookdatabase.dart';
import 'package:whisperverse_app/providers/isfavoriteprovider.dart';
import 'package:whisperverse_app/stories/storymodel.dart';

class Storypages extends ConsumerWidget {
  const Storypages({super.key, required this.book});
  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late List<Book> myfavoritestory;
    late Isfavoriteprovider isFavorite;
    isFavorite = ref.watch(favoriteProvider.notifier);
    myfavoritestory = ref.watch(favoriteProvider);
    final isFav = myfavoritestory.any((b) => b.uid == book.uid);

    final double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        title: Image.asset(width: 100, 'assets/images/logo2.png'),
        centerTitle: true,
        actionsPadding: EdgeInsets.only(right: 5),
        actions: [
          IconButton(
            onPressed: () {
              isFavorite.toggleFavorite(book);
            },
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 240, 214, 204),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chapter 1',
              style: GoogleFonts.fredoka(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
            ),
            Text(
              'Too Many Heroes',
              style: GoogleFonts.fredoka(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Since this sounds like it could be for your storytelling app — splitting a long narrative into page-by-page reading — one extra thing worth planning for: splitting purely by word can land mid-sentence or mid-paragraph in visually awkward places. A common refinement is to split your source text by paragraph first (fullText.split()), then run the word-level packing within each paragraph, so you don\'t orphan a lone word from a new paragraph onto the end of the previous page.',
              style: GoogleFonts.literata(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
